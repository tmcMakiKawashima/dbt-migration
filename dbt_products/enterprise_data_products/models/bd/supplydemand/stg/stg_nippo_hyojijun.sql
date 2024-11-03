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
with stg_nippo_hyojijun as (
    select 
        send_date::varchar(20) as send_date,
        to_number(jpn_local_div)::number(38,0) as jpn_local_div,
        jpn_local::varchar(255) as jpn_local,
        areacd::varchar(1) as areacd,
        area::varchar(10) as area,
        area_display_name::varchar(255) as area_display_name,
        country_cd::varchar(3) as country_cd,
        country::varchar(255) as country,
        psc::varchar(2) as psc,
        affiliate_cd::varchar(2) as affiliate_cd,
        affiliate::varchar(255) as affiliate,
        affiliate_e::varchar(255) as affiliate_e,
        plant_cd::varchar(2) as plant_cd,
        plant::varchar(255) as plant,
        plant_e::varchar(255) as plant_e,
        line_cd::varchar(1) as line_cd,
        line::varchar(255) as line,
        line_e::varchar(255) as line_e,
        geoss_line::varchar(5) as geoss_line,
        to_number(line_sort)::number(38,0) as line_sort,
        to_number(area_sort)::number(38,0) as area_sort,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,
                jpn_local_div,
                areacd,
                country_cd,
                psc,
                affiliate_cd,
                plant_cd,
                line_cd
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_m_daily_sort_order_line') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_daily_sort_order_line') }})
)
select * exclude(aggkey)
from stg_nippo_hyojijun
where aggkey = 1
