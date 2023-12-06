with stg_yohinhinban as (
    select
    *,
    RANK() over (partition by dlrcd, cuno, ym order by edano desc) aggkey 
  from {{source('marketing_db_public','raw_yohinhinban')}}
)
select * from stg_yohinhinban
where aggkey = 1
