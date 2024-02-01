{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3207 as (
    select
        rtrim(mtkbn, ' 　')::varchar(1) as mtkbn,
        rtrim(strno, ' 　')::varchar(9) as strno,
        rtrim(dtlno, ' 　')::varchar(4) as dtlno,
        rtrim(prtnum, ' 　')::varchar(4) as prtnum,
        rtrim(prtnmcd, ' 　')::varchar(11) as prtnmcd,
        rtrim(hnbncd, ' 　')::varchar(15) as hnbncd,
        ldts
    from {{ ref('substr_ktrla025zz0kil3207') }}
)
select * from stg_ktrla025zz0kil3207

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
