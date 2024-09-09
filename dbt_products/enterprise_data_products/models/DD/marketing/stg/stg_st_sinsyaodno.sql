{{ config(snowflake_warehouse='DBT_WH') }}

with stg_st_sinsyaodno as (
  select
    *,
    RANK() over (partition by MD5_SINSYAODNO_LINK order by LDTS desc) aggkey
  from {{source('marketing_db_public','raw_st_sinsyaodno')}}
)
select * from stg_st_sinsyaodno
where aggkey = 1
