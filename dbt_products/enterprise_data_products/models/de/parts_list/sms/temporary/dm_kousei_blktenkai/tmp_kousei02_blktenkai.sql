with
  recursive dm_kousei_oya as (
    select
       syasyu,
       siyoubui,
       motosiyoubui,
       oyahin,
       gc,
       kohin,
       kosu,
       sentaku,
       id,
       tyohuku,
       torokujunk,
       torokujunm,
       mttime,
       torokujunk_com,
       torokujunm_com,
       1 as lv,
       id as path,
       ldts
    from {{ ref('tmp_kousei01_blktenkai') }}
    where siyoubui = oyahin
    union all
     select
       sg.syasyu,
       sg.siyoubui,
       sg.motosiyoubui,
       sg.oyahin,
       sg.gc,
       sg.kohin,
       sg.kosu,
       sg.sentaku,
       sg.id,
       sg.tyohuku,
      case
       when oy.torokujunk > sg.torokujunk then oy.torokujunk 
       else sg.torokujunk 
       end as torokujunk,
      case
       when oy.torokujunm < sg.torokujunm then oy.torokujunm 
       else sg.torokujunm 
       end as torokujunm,
       sg.mttime,
       sg.torokujunk_com,
       sg.torokujunm_com,
       oy.lv + 1 as lv,
       concat(oy.path, '.', sg.id) as path,
       sg.ldts
     from dm_kousei_oya as oy
     inner join {{ ref('tmp_kousei01_blktenkai') }} as sg
       on sg.oyahin = oy.kohin
       and sg.siyoubui = oy.siyoubui
       and sg.syasyu = oy.syasyu
       and not (sg.torokujunm <= oy.torokujunk or oy.torokujunm <= sg.torokujunk)
     where sg.motosiyoubui = oy.motosiyoubui or substr(sg.oyahin,8,1) = '-'
  ) ,
  kousei_set as(
    select * ,
           left(siyoubui,4) as kumitate,
           substr(siyoubui,5,2) as bui,
           substr(siyoubui,7,2) as vari,
           row_number() over (partition by syasyu,siyoubui order by path) as kouseijyun,
      case
        when torokujunk > torokujunk_com then torokujunk 
        else torokujunk_com 
        end as torokujunk_com_k,
      case
        when torokujunm < torokujunm_com then torokujunm 
        when torokujunm > torokujunm_com and torokujunm_com = '' then torokujunm
        else torokujunm_com 
        end as torokujunm_com_m
    from dm_kousei_oya
  ) ,
  com_set as(
    select * ,
      case
        when torokujunk = torokujunk_com_k and torokujunm = torokujunm_com_m then '0' //分割しないパターン
        when torokujunk < torokujunk_com_k and torokujunm = torokujunm_com_m then '1' //構成コメントが途中で追加
        when torokujunk = torokujunk_com_k and torokujunm > torokujunm_com_m then '2' //構成コメントが途中で削除
        when torokujunk < torokujunk_com_k and torokujunm > torokujunm_com_m then '3' //構成コメントが途中で追加削除
        end as toroku_flg
    from kousei_set
  )
  select syasyu,
         siyoubui,
         motosiyoubui,
         oyahin,
         gc,
         kohin,
         kosu,
         sentaku,
         kumitate,
         bui,
         vari,
         lv,
         kouseijyun,
         mttime,
         tyohuku,
         ldts,
       case
         when toroku_flg = '0' then torokujunk //分割しないパターン
         when toroku_flg = '1' then torokujunk_com_k //構成コメントが途中で追加
         when toroku_flg = '2' then torokujunk //構成コメントが途中で削除
         when toroku_flg = '3' then torokujunk_com_k //構成コメントが途中で追加削除
         end as torokujunk,
       case
         when toroku_flg = '0' then torokujunm //分割しないパターン
         when toroku_flg = '1' then torokujunm //構成コメントが途中で追加
         when toroku_flg = '2' then torokujunm_com_m //構成コメントが途中で削除
         when toroku_flg = '3' then torokujunm_com_m //構成コメントが途中で追加削除
         end as torokujunm
  from com_set
  union all
    select syasyu,
           siyoubui,
           motosiyoubui,
           oyahin,
           gc,
           kohin,
           kosu,
           sentaku,
           kumitate,
           bui,
           vari,
           lv,
           kouseijyun,
           mttime,
           '' as tyohuku,
           ldts,
           torokujunk, 
           torokujunk_com_k as torokujunm
    from com_set where toroku_flg in ('1' ,'3')
    union all
     select syasyu,
            siyoubui,
            motosiyoubui,
            oyahin,
            gc,
            kohin,
            kosu,
            sentaku,
            kumitate,
            bui,
            vari,
            lv,
            kouseijyun,
            mttime,
            '' as tyohuku,
            ldts,
            torokujunm_com_m as torokujunk,
            torokujunm
     from com_set where toroku_flg in ('2' ,'3')