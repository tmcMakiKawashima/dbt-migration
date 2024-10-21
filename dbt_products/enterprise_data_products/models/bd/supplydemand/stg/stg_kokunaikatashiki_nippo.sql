{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}}
                where 
                    (year,month) in (
                        select 
                            year,month
                        from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_ctl_model_vehicle_class') }}
                        where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_ctl_model_vehicle_class') }})
                        group by year,month
                    )
            {% endif %}
        "
    )
}}

with stg_kokunaikatashiki_nippo as (
    select 
        send_date::varchar(20) as send_date,
        ymd::varchar(10) as ymd,
        year::varchar(4) as year,
        month::varchar(2) as month,
        day::varchar(2) as day,
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
        daily_report_car_grcd::varchar(10) as daily_report_car_grcd,
        daily_report_car_gr::varchar(255) as daily_report_car_gr,
        id::varchar(2) as id,
        syasyu_cd::varchar(4) as syasyu_cd,
        sno::varchar(2) as sno,
        syamei::varchar(2) as syamei,
        to_number(model_name_cd)::number(38,0) as model_name_cd,
        to_number(unit_cd)::number(38,0) as unit_cd,
        unit::varchar(255) as unit,
        to_number(dom_exp_cd)::number(38,0) as dom_exp_cd,
        dom_exp::varchar(255) as dom_exp,
        katashiki::varchar(20) as katashiki,
        to_number(vol_result)::number(38,0) as vol_result,
        to_number(vol_final)::number(38,0) as vol_final,
        to_number(total_result)::number(38,0) as total_result,
        to_number(total_final)::number(38,0) as total_final,
        to_number(oem)::number(38,0) as oem,
        to_number(line_sort)::number(38,0) as line_sort,
        to_number(d_rep_car_sort)::number(38,0) as d_rep_car_sort,
        to_number(result_model_sort)::number(38,0) as result_model_sort,
        to_number(unit_sort)::number(38,0) as unit_sort,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,
                ymd,
                areacd,
                country_cd,
                psc,
                affiliate_cd,
                plant_cd,
                line_cd,
                geoss_line,
                daily_report_car_grcd,
                id,
                syasyu_cd,
                sno,
                syamei,
                model_name_cd,
                unit_cd,
                dom_exp_cd,
                katashiki,
                oem
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_ctl_model_vehicle_class') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_ctl_model_vehicle_class') }})
)
select * exclude(aggkey)
from stg_kokunaikatashiki_nippo
where aggkey = 1
