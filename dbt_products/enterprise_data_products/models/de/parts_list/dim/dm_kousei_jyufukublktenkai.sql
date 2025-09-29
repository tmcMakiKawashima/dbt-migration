{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        transient = false,
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}} th
                using (
                    select distinct 
                        syasyu,
                        kumitate,
                        bui
                    from {{ ref('tmp08_dm_kousei_jyufukublktenkai')}}) zt
                where th.syasyu = zt.syasyu
                  and th.kumitate = zt.kumitate
                  and th.bui = zt.bui;
            {% endif %}
        "
    )
}}
-- 車種,組立番号,部位の単位で置き換える
select * exclude(target, torokujun, seppenno, maxmttime, mttime),
current_timestamp()::timestamp_ntz(9) as ldts
from {{ ref('tmp08_dm_kousei_jyufukublktenkai')}}