{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3211 as (
    select
        rtrim(dlrcd, ' 　')::varchar(5) as dlrcd,
        rtrim(tmpcd, ' 　')::varchar(3) as tmpcd,
        rtrim(tmpnm, ' 　')::varchar(20) as tmpnm,
        rtrim(startmt, ' 　')::varchar(6) as startmt,
        rtrim(stopmt, ' 　')::varchar(6) as stopmt,
        ldts
    from {{ ref('substr_ktrla025zz0kil3211') }}
)
select * from stg_ktrla025zz0kil3211

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
