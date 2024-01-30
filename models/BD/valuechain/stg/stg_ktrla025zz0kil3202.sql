{{ config(materialized='incremental') }}

with stg_ktrla025zz0kil3202 as (
    select
        rtrim(mtkbn, ' 　')::varchar(1) as mtkbn,
        rtrim(r001, ' 　')::varchar(3) as r001,
        rtrim(carno, ' 　')::varchar(20) as carno,
        rtrim(sttldy, ' 　')::varchar(8) as sttldy,
        rtrim(dlrcd, ' 　')::varchar(5) as dlrcd,
        rtrim(ordrno, ' 　')::varchar(8) as ordrno,
        rtrim(r006, ' 　')::varchar(3) as r006,
        rtrim(r007, ' 　')::varchar(3) as r007,
        rtrim(r008, ' 　')::varchar(1) as r008,
        rtrim(r009, ' 　')::varchar(8) as r009,
        rtrim(r010, ' 　')::varchar(8) as r010,
        rtrim(r011, ' 　')::varchar(6) as r011,
        rtrim(r012, ' 　')::varchar(7) as r012,
        rtrim(r013, ' 　')::varchar(7) as r013,
        rtrim(r014, ' 　')::varchar(7) as r014,
        rtrim(r015, ' 　')::varchar(7) as r015,
        rtrim(r016, ' 　')::varchar(7) as r016,
        ldts
    from {{ ref('substr_ktrla025zz0kil3202') }}
)
select * from stg_ktrla025zz0kil3202

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
