with recursive siyoubui_blk as (
    -- 使用部位単位で関係するblkを求める
    -- 使用部位の直下のblkを求める
    select distinct a.syasyu, siyoubui, siyoubui as blkoya, kohin as blkko, 1 as blk_kaisou
    from {{ ref('stg_kousei') }} a
    inner join  {{ ref('tmp_target_syasyu') }} b
    on a.syasyu = b.syasyu
    where substr(siyoubui, 9, 1) = '*' and substr(kohin, 8, 1) = '-'
    and jigyoutai = '  ' 
    
    union all
    -- blkのblkがあるので再帰する
    select oy.syasyu, oy.siyoubui, oy.blkko as blkoya, sg.kohin as blkko, oy.blk_kaisou + 1 as blk_kaisou
    from siyoubui_blk as oy
    -- blkのblkを求める
      inner join (
        select distinct a.syasyu, siyoubui, kohin
        from {{ ref('stg_kousei') }} a
        inner join {{ ref('tmp_target_syasyu') }} b
        on a.syasyu = b.syasyu
        where substr(siyoubui, 8, 1) = '-' and substr(kohin, 8, 1) = '-'
        and jigyoutai = '  ' 
      ) as sg
      on sg.siyoubui = oy.blkko
      and sg.syasyu = oy.syasyu

), siyoubui_all as(
    -- 使用部位本体を足す
    select distinct a.syasyu, siyoubui, siyoubui as blkoya, siyoubui as blkko, 0 as blk_kaisou
    from {{ ref('stg_kousei') }} a
    inner join {{ ref('tmp_target_syasyu') }} b
    on a.syasyu = b.syasyu
    where substr(siyoubui, 9, 1) = '*'
    and jigyoutai = '  ' 

    union all
    select * from siyoubui_blk

) ,siyoubui_target as(
    --構成側でメンテがあった使用部位を求める
    select a.syasyu, a.siyoubui ,max(b.mttime) as maxmttime ,'0' as flg
    from  siyoubui_all a
      inner join {{ ref('stg_kousei') }} b
      on substr(a.blkko,1,6) = substr(b.siyoubui,1,6)
      and a.syasyu = b.syasyu
      left outer join {{ source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai') }} d
      on a.syasyu = d.syasyu
      where b.jigyoutai = '  '
      and (d.target = 'KOUSEI' or d.target is null)
      and (d.syasyu is null or( a.syasyu = d.syasyu and b.mttime > d.maxmttime))
      group by a.syasyu, a.siyoubui
      union all

    --コメント側でメンテがあった使用部位を求める
    select a.syasyu, a.siyoubui ,max(c.mttime) as maxmttime ,'1' as flg
    from  siyoubui_all a
      inner join {{ ref('stg_kouseicom') }} c
      on substr(a.blkko,1,6) = substr(c.siyoubui,1,6)
      and a.syasyu = c.syasyu
      left outer join {{ source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai') }} d
      on a.syasyu = d.syasyu
      where c.jigyoutai = '  '
      and (d.target = 'KOUSEI' or d.target is null)
      and (d.syasyu is null or (a.syasyu = d.syasyu and c.mttime > d.maxmttime))
      and c.comkbn in ('11')
      group by a.syasyu, a.siyoubui

) ,kousei_all as(
    --更新対象の使用部位が求まった為、blkまで考慮し構成まで求める
    select distinct
    c.syasyu, b.siyoubui as siyoubui,c.siyoubui as motosiyoubui,c.oyahin, c.gc, c.kohin,c.kosu,c.sentaku,
    c.torokujunk,c.torokujunm,c.mttime,c.ldts,
    --gc含めた行idを振るため事前に求める項目
    case when c.gc is null or trim(c.gc) = '' then '0' else '1' end as gc_fill
    from siyoubui_target a
    inner join siyoubui_all b
    on  a.siyoubui = b.siyoubui
    and a.syasyu = b.syasyu
    inner join {{ ref('stg_kousei') }} c
    on b.blkko = c.siyoubui
    and a.syasyu = c.syasyu
    where c.jigyoutai = '  '

  )
  --使用部位単位に行idを付与
  select * ,cast(lpad(row_number() over (partition by syasyu, siyoubui order by concat(gc_fill,kohin,gc)),4,'0') as varchar) as id
  from kousei_all