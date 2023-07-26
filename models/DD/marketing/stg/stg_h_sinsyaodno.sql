with stg_h_sinsyaodno as (
  select
    *,
    RANK() over (partition by MD5_SINSYAODNO_HUB order by LDTS desc) aggkey 
  from {{source('marketing_db_public','raw_h_sinsyaodno')}}
)
select * from stg_h_sinsyaodno
where aggkey = 1
