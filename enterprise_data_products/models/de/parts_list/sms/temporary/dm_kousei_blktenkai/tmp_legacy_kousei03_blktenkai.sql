{{
    config(
        materialized='table',
        post_hook = "
            update {{this}} u --tmp_junkanri03_blktenkai
                set torokutimem = s.next_timestamp
            from (
                select 
                     k3.syasyu,
                     k3.siyoubui,
                     k3.torokujunk,
                     k3.torokujunm,
                     k3.mttime,
                     k3.next_torokujun,
                     nvl(j.mttime, '9999123123595999') as next_timestamp
                from (
                    select
                        k1.*,
                        nvl((
                            select
                                min(torokujunm)
                            from
                                {{this}} k2
                            inner join {{ ref('stg_legacy_mokujihonshijun') }} j -- 目次本紙設変登録順管理
                              on k2.syasyu = j.syasyu_cd
                              and k2.torokujunm = j.torokujun
                              and trim(j.jigyoutai) = ''
                            where
                              k2.syasyu = k1.syasyu
                              and k2.siyoubui = k1.siyoubui
                              and k2.torokujunk >= k1.torokujunm
                              and j.mttime > k1.mttime), '999999999') as next_torokujun
                    from (
                        select
                            distinct syasyu,
                            siyoubui,
                            torokujunk,
                            torokujunm,
                            mttime
                        from
                            {{this}} --tmp_junkanri03_blktenkai
                        where
                          torokutimek > torokutimem
                       ) k1
                ) k3
            left join {{ ref('stg_legacy_mokujihonshijun') }} j -- 目次本紙設変登録順管理
              on k3.syasyu = j.syasyu_cd
              and k3.next_torokujun = j.torokujun
              and trim(j.jigyoutai) = ''
            ) s
            where u.torokutimek > u.torokutimem
              and u.syasyu = s.syasyu
              and u.siyoubui = s.siyoubui
              and u.torokujunk = s.torokujunk
              and u.torokujunm = s.torokujunm
        "
    )
}}
-- KARA MADE MODIFY
-- tmp_junkanri03_blktenkai作成時付与した設変Noマデに対して更新を行うためpost_hookの実施する。

with
    tmp02 as (
        select * from {{ ref('tmp_legacy_kousei02_blktenkai') }}
    ),
    hinban as (
        select
            hinban, -- 品番
            hinmei -- 品名
        from {{ ref('stg_hinban') }} -- 品番情報
        where substr(hinban, 8, 1) != '-'
        and kekka = '1'
    ),
    blkmei as (
        select
            syasyu, -- 車種ユニットコード
            blkcode, -- BLKコード
            blkmei -- BLKコード名称
        from {{ ref('stg_legacy_blkmei') }} -- BLKコード名称
        where substr(blkcode, 8, 1) = '-'
    ),
    mokujihonshijun as (
        select
            syasyu_cd, -- 車種コード
            seppenno, -- 設変No.
            torokujun, -- 登録／生認順
            mttime --MT日時
        from {{ ref('stg_legacy_mokujihonshijun') }} -- 目次本紙設変登録順管理
        where jigyoutai = '  '
    )
select
    tmp02.* exclude(mttime),
    hinban.hinmei,
    blkmei.blkmei,
    kara.seppenno,
    kara.seppenno as seppennok, -- 現行に合わせて列別名付与
    case 
     when tmp02.torokujunm = '999999999' then ''
     else made.seppenno
    end as seppennom, -- 現行に合わせて列別名付与
    kara.mttime as torokutimek, -- 現行に合わせて列別名付与
    case 
     when tmp02.torokujunm = '999999999' then '9999123123595999'
     else made.mttime
    end as torokutimem, -- 現行に合わせて列別名付与
    case
     when kara.mttime < made.mttime then made.mttime
     else kara.mttime
    end as mttime
from tmp02
left outer join hinban
  on tmp02.kohin = hinban.hinban
left outer join blkmei
  on tmp02.syasyu = blkmei.syasyu
  and tmp02.kohin = blkmei.blkcode
left outer join mokujihonshijun as kara
  on tmp02.syasyu = kara.syasyu_cd
  and tmp02.torokujunk = kara.torokujun
left outer join mokujihonshijun as made
  on tmp02.syasyu = made.syasyu_cd
  and tmp02.torokujunm = made.torokujun