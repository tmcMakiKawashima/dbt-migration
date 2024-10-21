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

with stg_katashiki_syasyuteigi as (
    select 
        send_date::varchar(20) as send_date,
        syasyu_cd::varchar(4) as syasyu_cd,
        sno::varchar(2) as sno,
        syamei::varchar(2) as syamei,
        to_number(dom_exp_cd)::number(38,0) as dom_exp_cd,
        dom_exp::varchar(255) as dom_exp,
        to_number(model_name_cd)::number(38,0) as model_name_cd,
        to_number(unit_cd)::number(38,0) as unit_cd,
        unit::varchar(255) as unit,
        to_number(no_jpn_model_m)::number(38,0) as no_jpn_model_m,
        katashiki::varchar(20) as katashiki,
        to_number(result_model_sort)::number(38,0) as result_model_sort,
        to_number(unit_sort)::number(38,0) as unit_sort,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,
                syasyu_cd,
                sno,
                syamei,
                dom_exp_cd,
                model_name_cd,
                unit_cd,
                katashiki
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_m_ctl_model_vehicle_class') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_ctl_model_vehicle_class') }})
)
select * exclude(aggkey)
from stg_katashiki_syasyuteigi
where aggkey = 1
