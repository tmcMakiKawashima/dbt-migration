{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3204 as (
    select
        rtrim(mtkbn, ' 　')::varchar(1) as mtkbn,
        rtrim(strno, ' 　')::varchar(9) as strno,
        rtrim(dtlno, ' 　')::varchar(4) as dtlno,
        rtrim(grtpa, ' 　')::varchar(1) as grtpa,
        rtrim(t1wcd, ' 　')::varchar(4) as t1wcd,
        rtrim(refcd, ' 　')::varchar(10) as refcd,
        ldts
    from {{ ref('substr_ktrla025zz0kil3204') }}
)
select * from stg_ktrla025zz0kil3204

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
