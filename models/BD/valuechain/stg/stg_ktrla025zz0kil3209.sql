{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3209 as (
    select
        rtrim(cdkbnid, ' 　')::varchar(3) as cdkbnid,
        rtrim(keykomoku, ' 　')::varchar(2) as keykomoku,
        rtrim(datakomoku, ' 　')::varchar(20) as datakomoku,
        rtrim(timestamp, ' 　')::varchar(26) as timestamp,
        ldts
    from {{ ref('substr_ktrla025zz0kil3209') }}
)
select * from stg_ktrla025zz0kil3209

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
