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
        R001::varchar(9) as nyukono,
        R002::varchar(4) as meisaino,
        R003::varchar(8) as sainyukoymd,
        R004::varchar(1) as tyoushiukagaikekkacd,
        R005::varchar(2) as genincd,
        R006::varchar(2) as hosyokbn,
        rtrim(R007, ' 　')::varchar(12) as hosyoseikyusyono, -- 右blank
        R008::varchar(1) as huguaisaigenumu,
        rtrim(R009, ' 　')::varchar(50) as geninmeisyo, -- 右blank
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3205') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_goyoumeihosyo where aggkey = 1