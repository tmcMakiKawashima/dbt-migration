{{ config(snowflake_warehouse='DBT_WH') }}

with stg_st_jpsalecar as (
  select
    *,
    RANK() over (partition by MD5_JPSALECAR_HUB order by LDTS desc) aggkey
  from {{source('supplydemand_db_public', 'raw_st_jpsalecar')}}
)
select * from stg_st_jpsalecar
where aggkey = 1
