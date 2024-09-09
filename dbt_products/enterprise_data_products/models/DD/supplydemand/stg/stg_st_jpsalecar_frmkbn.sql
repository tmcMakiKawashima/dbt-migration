{{ config(snowflake_warehouse='DBT_WH') }}

with stg_st_jpsalecar_frmkbn as (
  select
    *,
    RANK() over (partition by MD5_JPSALECAR_HUB order by LDTS desc) aggkey
  from {{source('supplydemand_db_public','raw_st_jpsalecar_frmkbn')}}
)
select * from stg_st_jpsalecar_frmkbn
where aggkey = 1
