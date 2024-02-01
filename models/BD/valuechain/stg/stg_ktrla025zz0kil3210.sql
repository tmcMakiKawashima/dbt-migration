{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3210 as (
    select
        rtrim(dlrcd, ' 　')::varchar(5) as dlrcd,
        rtrim(tmpnm, ' 　')::varchar(5) as tmpnm,
        ldts
    from {{ ref('substr_ktrla025zz0kil3210') }}
)
select * from stg_ktrla025zz0kil3210

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
