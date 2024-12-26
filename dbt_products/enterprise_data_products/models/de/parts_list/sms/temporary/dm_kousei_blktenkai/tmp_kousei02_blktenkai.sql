with 
  recursive dm_kousei_oya as(
    select *
      , 1 as lv
      , id as path
    from tmp_kousei01_blktenkai
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
               oy.lv + 1 as lv,
               concat(oy.path, '.', sg.id) as path
      from dm_kousei_oya as oy
        inner join tmp_kousei01_blktenkai as sg
          on sg.oyahin = oy.kohin
          and sg.siyoubui = oy.siyoubui
          and sg.syasyu = oy.syasyu
          and not (sg.torokujunm <= oy.torokujunk or oy.torokujunm <= sg.torokujunk)
      where sg.motosiyoubui = oy.motosiyoubui or substr(sg.oyahin, 8, 1) = '-'
  )
    select *,
      left(siyoubui, 4) as kumitate,
      substr(siyoubui, 5, 2) as bui,
      substr(siyoubui, 7, 2) as vari,
      row_number() over(partition by syasyu, siyoubui order by path) as seq
    from dm_kousei_oya