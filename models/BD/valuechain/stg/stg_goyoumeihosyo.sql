{{
    config(
        materialized = 'incremental',
        unique_key = ['nyukono','meisaino'],
        incremental_strategy = 'merge'
    )
}}

with stg_goyoumeihosyo as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        r001::varchar(9) as nyukono,
        r002::varchar(4) as meisaino,
        r003::varchar(8) as sainyukoymd,
        r004::varchar(1) as tyoushiukagaikekkacd,
        r005::varchar(2) as genincd,
        r006::varchar(2) as hosyokbn,
        rtrim(r007, ' 　')::varchar(12) as hosyoseikyusyono, -- 右blank
        r008::varchar(1) as huguaisaigenumu,
        rtrim(r009, ' 　')::varchar(50) as geninmeisyo, -- 右blank
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3205') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_goyoumeihosyo where aggkey = 1