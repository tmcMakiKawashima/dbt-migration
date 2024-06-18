{{ config(snowflake_warehouse='DBT_WH') }}

with stg_yohinhinban as (
    select
    trim(cuno) as cuno, * exclude(cuno),
    RANK() over (partition by dlrcd, cuno, ym order by edano desc) aggkey 
  from {{source('marketing_db_public','raw_yohinhinban')}}
)
select * from stg_yohinhinban
where aggkey = 1
