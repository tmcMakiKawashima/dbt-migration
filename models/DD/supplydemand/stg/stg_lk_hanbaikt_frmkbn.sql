{{ config(snowflake_warehouse='DBT_WH') }}

with stg_lk_hanbaikt_frmkbn as (
  select
    *,
    RANK() over (partition by MD5_HANBAIKT_LINK order by LDTS desc) aggkey
  from {{source('supplydemand_db_public','raw_lk_hanbaikt_frmkbn')}}
  where DEL_FLG = '0'
)
select * from stg_lk_hanbaikt_frmkbn
where aggkey = 1
