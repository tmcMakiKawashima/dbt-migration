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
-- create or replaceでは、後続のマテリアライズドビューに影響が出るため
-- incremental append + pre_hookによる洗い替え処理を実装
with stg_kudo as (
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
        katashiki::varchar(20) as katashiki,
        to_number(jpn)::number(38,0) as jpn,
        to_number(kd)::number(38,0) as kd,
        to_number(powertrain_cd)::number(38,0) as powertrain_cd,
        powertrain::varchar(255) as powertrain,
        powertrain_sms::varchar(10) as powertrain_sms,
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
                katashiki,
                powertrain_cd,
                powertrain_sms
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_m_drive') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_drive') }})
)
select * exclude(aggkey)
from stg_kudo
where aggkey = 1
