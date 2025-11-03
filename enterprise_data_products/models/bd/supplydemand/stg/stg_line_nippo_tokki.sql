{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}}
                where 
                    (year,month,jpn_local_div) in (
                        select 
                            year,month,jpn_local_div
                        from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_line_detail_reason') }}
                        where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_line_detail_reason') }})
                        group by year,month,jpn_local_div
                    )
            {% endif %}
        "
    )
}}
-- ソース元システムにてキー情報の物理削除があり得る為
-- incremental append + pre_hookによる受領年月・国内海外区分単位の洗い替えを実施
with stg_line_nippo_tokki as (
    select 
        send_date::varchar(20) as send_date,
        ymd::varchar(10) as ymd,
        year::varchar(4) as year,
        month::varchar(2) as month,
        day::varchar(2) as day,
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
        to_number(item_cd)::number(38,0) as item_cd,
        item::varchar(255) as item,
        to_number(disp_flg)::number(38,0) as disp_flg,
        shift_cd::varchar(1) as shift_cd,
        shift::varchar(255) as shift,
        to_number(process_cd)::number(38,0) as process_cd,
        process::varchar(255) as process,
        to_number(reason_div_cd)::number(38,0) as reason_div_cd,
        reason_div::varchar(255) as reason_div,
        to_number(reason_div1_cd)::number(38,0) as reason_div1_cd,
        reason_div1::varchar(255) as reason_div1,
        to_number(reason_div2_cd)::number(38,0) as reason_div2_cd,
        reason_div2::varchar(255) as reason_div2,
        to_number(stop_t)::number(38,0) as stop_t,
        to_number(ot,7,2)::number(7,2) as ot,
        memo::varchar(255) as memo,
        to_number(outside_criteria)::number(38,0) as outside_criteria,
        to_number(area_sort)::number(38,0) as area_sort,
        to_number(line_sort)::number(38,0) as line_sort,
        to_number(item_sort)::number(38,0) as item_sort,
        to_number(process_sort)::number(38,0) as process_sort,
        to_number(reason_div_sort)::number(38,0) as reason_div_sort,
        to_number(reason_div1_sort)::number(38,0) as reason_div1_sort,
        to_number(reason_div2_sort)::number(38,0) as reason_div2_sort,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by
                send_date,
                ymd,
                jpn_local_div,
                areacd,
                country_cd,
                psc,
                affiliate_cd,
                plant_cd,
                line_cd,
                item_cd,
                shift_cd,
                process_cd,
                reason_div_cd,
                reason_div1_cd,
                reason_div2_cd,
                stop_t,
                ot,
                memo
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_line_detail_reason') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_line_detail_reason') }})
)
select * exclude(aggkey)
from stg_line_nippo_tokki
where aggkey = 1
