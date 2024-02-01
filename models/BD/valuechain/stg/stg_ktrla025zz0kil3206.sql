{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3206 as (
    select
        rtrim(mtkbn, ' 　')::varchar(1) as mtkbn,
        rtrim(strno, ' 　')::varchar(9) as strno,
        rtrim(dtlno, ' 　')::varchar(4) as dtlno,
        rtrim(seibinmcd, ' 　')::varchar(11) as seibinmcd,
        rtrim(seibicd, ' 　')::varchar(8) as seibicd,
        ldts
    from {{ ref('substr_ktrla025zz0kil3206') }}
)
select * from stg_ktrla025zz0kil3206

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
