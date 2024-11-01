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
# create or replaceでは、後続のマテリアライズドビューに影響が出るため
# incremental append + pre_hookによる洗い替え処理を実装
with stg_seisanpattern_syasyumei as (
    select 
        send_date::varchar(20) as send_date,
        to_number(jpn_local_div)::number(38,0) as jpn_local_div,
        jpn_local::varchar(255) as jpn_local,
        to_number(model_name_cd)::number(38,0) as model_name_cd,
        model_name::varchar(255) as model_name,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,
                jpn_local_div,
                model_name_cd
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_m_vehicle_class_name') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_vehicle_class_name') }})
)
select * exclude(aggkey)
from stg_seisanpattern_syasyumei
where aggkey = 1
