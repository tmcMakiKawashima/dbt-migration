{{ config(materialized='incremental') }}
-- カラムをリネームしたい
with stg_ktrla025zz0kil3205 as (
    select
        rtrim(mtkbn, ' 　')::varchar(1) as mtkbn,
        rtrim(strno, ' 　')::varchar(9) as strno,
        rtrim(dtlno, ' 　')::varchar(4) as dtlno,
        rtrim(sainyukodate, ' 　')::varchar(8) as sainyukodate,
        rtrim(choushikekkacd, ' 　')::varchar(1) as choushikekkacd,
        rtrim(genincd, ' 　')::varchar(2) as genincd,
        rtrim(hosyokbn, ' 　')::varchar(2) as hosyokbn,
        rtrim(hosyoseikyusyono, ' 　')::varchar(12) as hosyoseikyusyono,
        rtrim(fuguaisaigenkbn, ' 　')::varchar(1) as fuguaisaigenkbn,
        rtrim(geninname, ' 　')::varchar(50) as geninname,
        ldts
    from {{ ref('substr_ktrla025zz0kil3205') }}
)
select * from stg_ktrla025zz0kil3205

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}
