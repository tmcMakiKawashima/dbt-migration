{{ config(snowflake_warehouse='DBT_WH') }}

with
    temp30 as (select * from {{ ref('tmp30_dm_hosyuhin_tmp_juhattyuuriage') }}),
    nouki as (select * from {{ ref('stg_tbnoukifl') }} where nokikbn = '6'),
    nouki_initial as (select * from {{ ref('stg_tbnoukifl_initial') }}),
    nouki_previous as (select * from {{ ref('stg_tbnoukifl_previous') }}),
    nouki_latest as (select * from {{ ref('stg_tbnoukifl_latest') }})
select
    temp30.* exclude (check_kyouhan),
    nouki.nokiymd,
    nouki_initial.nokiymd syukayotei_min,
    nouki_initial.binno syukayoteibinno_min,
    nouki_previous.nokiymd syukayotei_prev,
    nouki_previous.binno syukayoteibinno_prev,
    nouki_latest.nokiymd syukayotei_max,
    nouki_latest.binno syukayoteibinno_max,
    nouki.kyouhan as check1_kyouhan, -- 共販店コード１ nullチェック用
    nouki_initial.kyouhan as check2_kyouhan, -- 共販店コード２ nullチェック用
    nouki_previous.kyouhan as check3_kyouhan, -- 共販店コード３ nullチェック用
    nouki_latest.kyouhan as check4_kyouhan -- 共販店コード４ nullチェック用
from temp30
    left outer join nouki
        on temp30.kyouhan = nouki.kyouhan
        and temp30.hinban = nouki.hinban
        and temp30.mkbn = nouki.mkbn
        and temp30.nyukkten = nouki.nyukktn
        and temp30.chumon = nouki.chumon
        and temp30.jdenno = nouki.jdenno
        and temp30.jchuymd = nouki.jchuymd
        and temp30.jchutime = nouki.jchutime
        and temp30.bof_kasyuu = nouki.usercd
    left outer join nouki_initial
        on temp30.kyouhan = nouki_initial.kyouhan
        and temp30.hinban = nouki_initial.hinban
        and temp30.mkbn = nouki_initial.mkbn
        and temp30.nyukkten = nouki_initial.nyukktn
        and temp30.chumon = nouki_initial.chumon
        and temp30.jdenno = nouki_initial.jdenno
        and temp30.jchuymd = nouki_initial.jchuymd
        and temp30.jchutime = nouki_initial.jchutime
        and temp30.bof_kasyuu = nouki_initial.usercd
    left outer join nouki_previous
        on temp30.kyouhan = nouki_previous.kyouhan
        and temp30.hinban = nouki_previous.hinban
        and temp30.mkbn = nouki_previous.mkbn
        and temp30.nyukkten = nouki_previous.nyukktn
        and temp30.chumon = nouki_previous.chumon
        and temp30.jdenno = nouki_previous.jdenno
        and temp30.jchuymd = nouki_previous.jchuymd
        and temp30.jchutime = nouki_previous.jchutime
        and temp30.bof_kasyuu = nouki_previous.usercd
    left outer join nouki_latest
        on temp30.kyouhan = nouki_latest.kyouhan
        and temp30.hinban = nouki_latest.hinban
        and temp30.mkbn = nouki_latest.mkbn
        and temp30.nyukkten = nouki_latest.nyukktn
        and temp30.chumon = nouki_latest.chumon
        and temp30.jdenno = nouki_latest.jdenno
        and temp30.jchuymd = nouki_latest.jchuymd
        and temp30.jchutime = nouki_latest.jchutime
        and temp30.bof_kasyuu = nouki_latest.usercd
