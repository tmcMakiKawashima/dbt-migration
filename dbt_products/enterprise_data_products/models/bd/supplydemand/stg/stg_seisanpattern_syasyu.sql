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
with stg_seisanpattern_syasyu as (
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
        shimukechi_cd::varchar(4) as shimukechi_cd,
        id::varchar(2) as id,
        syasyu_cd::varchar(4) as syasyu_cd,
        sno::varchar(2) as sno,
        syamei::varchar(2) as syamei,
        to_number(dom_exp_cd)::number(38,0) as dom_exp_cd,
        dom_exp::varchar(255) as dom_exp,
        to_number(model_name_cd)::number(38,0) as model_name_cd,
        to_number(unit_cd)::number(38,0) as unit_cd,
        unit::varchar(255) as unit,
        company::varchar(255) as company,
        daily_report_car_grcd::varchar(10) as daily_report_car_grcd,
        daily_report_car_gr::varchar(255) as daily_report_car_gr,
        to_number(local_daily_report)::number(38,0) as local_daily_report,
        to_number(local_result)::number(38,0) as local_result,
        to_number(local_result_kd)::number(38,0) as local_result_kd,
        to_number(packing_geoss)::number(38,0) as packing_geoss,
        to_number(packing_dest)::number(38,0) as packing_dest,
        to_number(packing_lot)::number(38,0) as packing_lot,
        to_number(packing_pxp)::number(38,0) as packing_pxp,
        to_number(packing_kd)::number(38,0) as packing_kd,
        packing_tc_from::varchar(10) as packing_tc_from,
        packing_tc_to::varchar(10) as packing_tc_to,
        tc_from::varchar(10) as tc_from,
        tc_to::varchar(10) as tc_to,
        to_number(new_line_flg)::number(38,0) as new_line_flg,
        result_only_tc_from::varchar(10) as result_only_tc_from,
        to_number(oem)::number(38,0) as oem,
        to_number(only_for_result)::number(38,0) as only_for_result,
        to_number(no_katashiki_result)::number(38,0) as no_katashiki_result,
        to_number(no_key_field)::number(38,0) as no_key_field,
        employee_cd::varchar(10) as employee_cd,
        employee::varchar(255) as employee,
        to_number(area_sort)::number(38,0) as area_sort,
        to_number(line_sort)::number(38,0) as line_sort,
        to_number(result_model_sort)::number(38,0) as result_model_sort,
        to_number(unit_sort)::number(38,0) as unit_sort,
        to_number(d_rep_car_sort)::number(38,0) as d_rep_car_sort,
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
                line_cd,
                geoss_line,
                shimukechi_cd,
                id,
                syasyu_cd,
                sno,
                syamei,
                dom_exp_cd,
                model_name_cd,
                unit_cd,
                packing_tc_from,
                packing_tc_to,
                tc_from,
                tc_to,
                result_only_tc_from
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_m_vehicle_class') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_vehicle_class') }})
)
select * exclude(aggkey)
from stg_seisanpattern_syasyu
where aggkey = 1
