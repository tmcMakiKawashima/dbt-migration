with
    temp10 as (select * from {{ ref('tmp10_dm_hosyuhin_tmp_juhattyuuriage') }}),
    chuzan as (select * from {{ ref('stg_tbchznl') }})
select
    temp10.*,
    chuzan.hchuymd chuzan_hchuymd,
    --納期仕向
    chuzan.odrsbetu,
    chuzan.ktenkbn
from temp10
    left outer join chuzan
        on temp10.kyouhan = chuzan.kyouhan
        and temp10.hinban = chuzan.hinban
        and temp10.mkbn = chuzan.mkbn
        and temp10.nyukkten = chuzan.nyukkten
        and temp10.chumon = chuzan.chumon
        and temp10.jchuymd <= chuzan.hchuymd
        and temp10.hchuymd >= chuzan.hchuymd
