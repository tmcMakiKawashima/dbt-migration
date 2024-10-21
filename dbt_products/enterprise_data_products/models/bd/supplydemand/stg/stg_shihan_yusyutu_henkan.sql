{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}}
            {% endif %}
        "
    )
}}

with stg_shihan_yusyutu_henkan as (
    select 
        send_date::varchar(20) as send_date,
        syasyu_cd::varchar(4) as syasyu_cd,
        sno::varchar(2) as sno,
        syamei::varchar(2) as syamei,
        to_number(nippo_sys_de_cd)::number(38,0) as nippo_sys_de_cd,
        nippo_sys_de::varchar(255) as nippo_sys_de,
        to_number(changed_de_cd)::number(38,0) as changed_de_cd,
        changed_de::varchar(255) as changed_de,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,
                syasyu_cd,
                sno,
                syamei
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_m_convert_commercial_export') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_convert_commercial_export') }})
)
select * exclude(aggkey)
from stg_shihan_yusyutu_henkan
where aggkey = 1
