{{ config(snowflake_warehouse='DBT_WH') }}

with stg_cvn18nosiodrjyoho as (
    select
        *,
        rank() over (partition by ordrkey, juchuymd order by ldts desc) aggkey
    from {{ ref('stg_cvn18nosiodrjyoho') }}
)
select * from stg_cvn18nosiodrjyoho
where aggkey = 1
