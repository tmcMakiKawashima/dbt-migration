{{ config(snowflake_warehouse='DBT_WH') }}

with stg_st_hanbaikt_frmkbn as (
  select
    *,
    RANK() over (partition by MD5_HANBAIKT_LINK order by LDTS desc) aggkey
  from {{source('supplydemand_db_public','raw_st_hanbaikt_frmkbn')}}
)
select * from stg_st_hanbaikt_frmkbn
where aggkey = 1
