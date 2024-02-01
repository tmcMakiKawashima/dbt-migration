{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3203 as (
    select
        rtrim(mtkbn, ' 　')::varchar(1) as mtkbn,
        rtrim(dlrcd, ' 　')::varchar(5) as dlrcd,
        rtrim(ordrno, ' 　')::varchar(8) as ordrno,
        rtrim(sttldy, ' 　')::varchar(8) as sttldy,
        rtrim(nyukono, ' 　')::varchar(9) as nyukono,
        ldts
    from {{ ref('substr_ktrla025zz0kil3203') }}
)
select * from stg_ktrla025zz0kil3203

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
