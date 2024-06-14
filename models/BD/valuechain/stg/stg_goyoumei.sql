{{
    config(
        materialized = 'incremental',
        unique_key = ['nyukono','meisaino'],
        incremental_strategy = 'merge'
    )
}}

with stg_goyoumei as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(R001, ' 　')::varchar(9) as nyukono,
        rtrim(R002, ' 　')::varchar(4) as meisaino,
        rtrim(R005, ' 　')::varchar(1) as hosyokbn,
        rtrim(R004, ' 　')::varchar(4) as t1w,
        rtrim(R006, ' 　')::varchar(10) as goyomeisansyocd,
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3204') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_goyoumei where aggkey = 1