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

with stg_gekkan_kadojisseki as (
    select 
        send_date::varchar(20) as send_date,
        ym::varchar(7) as ym,
        year::varchar(4) as year,
        month::varchar(2) as month,
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
        to_number(result_type_cd)::number(38,0) as result_type_cd,
        result_type::varchar(255) as result_type,
        geoss_line::varchar(5) as geoss_line,
        shimukechi_cd::varchar(4) as shimukechi_cd,
        to_number(jpn_model_name_cd)::number(38,0) as jpn_model_name_cd,
        to_number(local_model_name_cd)::number(38,0) as local_model_name_cd,
        to_number(unit_cd)::number(38,0) as unit_cd,
        unit::varchar(255) as unit,
        to_number(error)::number(38,0) as error,
        id::varchar(2) as id,
        syasyu_cd::varchar(4) as syasyu_cd,
        sno::varchar(2) as sno,
        syamei::varchar(2) as syamei,
        to_number(de_total_cd)::number(38,0) as de_total_cd,
        de_total::varchar(255) as de_total,
        katashiki::char(20) as katashiki,
        to_number(powertrain_cd)::number(38,0) as powertrain_cd,
        powertrain::varchar(255) as powertrain,
        to_number(result_default)::number(38,0) as result_default,
        to_number(result_revise)::number(38,0) as result_revise,
        to_number(result_cbu)::number(38,0) as result_cbu,
        to_number(result_kd)::number(38,0) as result_kd,
        to_number(result_cbu_kd)::number(38,0) as result_cbu_kd,
        to_number(oem)::number(38,0) as oem,
        to_number(only_for_result)::number(38,0) as only_for_result,
        to_number(no_katashiki_result)::number(38,0) as no_katashiki_result,
        to_number(warning_diff_kata)::number(38,0) as warning_diff_kata,
        to_number(only_kd)::number(38,0) as only_kd,
        to_number(completion)::number(38,0) as completion,
        completion_t::varchar(20) as completion_t,
        employee_cd::varchar(10) as employee_cd,
        employee::varchar(100) as employee,
        to_number(confirmed_flg)::number(38,0) as confirmed_flg,
        confirmed_t::varchar(20) as confirmed_t,
        to_number(area_sort)::number(38,0) as area_sort,
        to_number(line_sort)::number(38,0) as line_sort,
        to_number(result_model_sort)::number(38,0) as result_model_sort,
        to_number(unit_sort)::number(38,0) as unit_sort,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,ym,jpn_local_div,areacd,country_cd,psc,affiliate_cd,plant_cd,line_cd,result_type_cd,geoss_line,shimukechi_cd,jpn_model_name_cd,local_model_name_cd,unit_cd,error,id,syasyu_cd,sno,syamei,de_total_cd,katashiki,powertrain_cd,oem,only_for_result,no_katashiki_result,warning_diff_kata,only_kd,completion,employee_cd,confirmed_flg
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_t_monthly_reports') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_monthly_reports') }})
)
select * exclude(aggkey)
from stg_gekkan_kadojisseki
where aggkey = 1
