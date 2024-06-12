{{
    config(
        materialized = 'incremental',
        unique_key = ['nyukono','meisaino'],
        incremental_strategy = 'merge'
    )
}}

with stg_buhinreki as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(R001, ' 　')::varchar(9) as nyukono,
        rtrim(R002, ' 　')::varchar(4) as meisaino,
        rtrim(R003, ' 　')::varchar(4) as buhinsuryo,
        rtrim(R005, ' 　')::varchar(11) as buhinmeisyosansyocd,
        rtrim(R006, ' 　')::varchar(15) as hinban,
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3207') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)

select * from stg_buhinreki where aggkey = 1
