{{ config(snowflake_warehouse='DBT_WH') }}

with stg_h_hanbaikt_frmkbn as (
  select
    *,
    RANK() over (partition by MD5_HANBAIKT_HUB order by LDTS desc) aggkey
  from {{source('supplydemand_db_public','raw_h_hanbaikt_frmkbn')}}
)
select * from stg_h_hanbaikt_frmkbn
where aggkey = 1
