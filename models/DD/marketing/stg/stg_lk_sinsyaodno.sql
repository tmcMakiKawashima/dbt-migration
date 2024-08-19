{{ config(snowflake_warehouse='DBT_WH') }}

with stg_lk_sinsyaodno as (
  select
    *,
    RANK() over (partition by MD5_SINSYAODNO_LINK order by LDTS desc) aggkey 
  from {{source('marketing_db_public','raw_lk_sinsyaodno')}}
  where DEL_FLG = '0'
)
select * from stg_lk_sinsyaodno
where aggkey = 1
