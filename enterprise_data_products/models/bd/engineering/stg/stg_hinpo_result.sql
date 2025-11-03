{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append'
  )
 }}
 
with stg_hinpo_result as (
    select
        quality_result_id::number(10,0) as quality_result_id,
        accept_test_id::number(10,0) as accept_test_id,
        test_date::timestamp_ntz(6) as test_date,
        l25::number(6,3) as l25,
        a25::number(6,3) as a25,
        b25::number(6,3) as b25,
        dl25::number(6,3) as dl25,
        da25::number(6,3) as da25,
        db25::number(6,3) as db25,
        de25::number(6,3) as de25,
        l45::number(6,3) as l45,
        a45::number(6,3) as a45,
        b45::number(6,3) as b45,
        dl45::number(6,3) as dl45,
        da45::number(6,3) as da45,
        db45::number(6,3) as db45,
        de45::number(6,3) as de45,
        l75::number(6,3) as l75,
        a75::number(6,3) as a75,
        b75::number(6,3) as b75,
        dl75::number(6,3) as dl75,
        da75::number(6,3) as da75,
        db75::number(6,3) as db75,
        de75::number(6,3) as de75,
        comments::varchar(300) as comments,
        remark::varchar(300) as remark,
        created_by::varchar(50) as created_by,
        created_at::timestamp_ntz(6) as created_at,
        ldts, -- b層のldts
        row_number() over(partition by quality_result_id order by created_at desc, line_number desc) aggkey
    from {{ source('snowpipe_db_engineering', 'raw_ktrla0g7zz0kqe0007') }}
           
{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}

)
select * exclude(aggkey) from stg_hinpo_result
where aggkey = 1

