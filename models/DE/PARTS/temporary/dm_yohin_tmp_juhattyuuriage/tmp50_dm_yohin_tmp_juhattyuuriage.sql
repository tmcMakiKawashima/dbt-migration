with
    temp30 as (select * from {{ ref("tmp30_dm_yohin_tmp_juhattyuuriage") }}),
    temp40 as (select * from {{ ref("tmp40_dm_yohin_tmp_juhattyuuriage") }})

select
      temp30.*
    , temp40.makercd
    , temp40.syukkosu
    , temp40.syukkoymd
    , temp40.kyouhan as check3_kyouhan -- nullチェック用    
from temp30
    left outer join temp40
        on temp30.kyouhan_ml = temp40.kyouhan
        and temp30.usercd_ml = temp40.usrcod
        and temp30.hanbaiten = temp40.hanabai
        and temp30.nyukohin = temp40.hinban
        and (
            temp40.dennoj = temp30.denno1
            or temp40.dennoj = temp30.denno2
            or temp40.dennoj = temp30.denno3
            or temp40.dennoj = temp30.denno4
        )
        and (
            temp40.syukkoymd = temp30.hikiate1
            or temp40.syukkoymd = temp30.hikiate2
            or temp40.syukkoymd = temp30.hikiate3
            or temp40.syukkoymd = temp30.hikiate4
        )
