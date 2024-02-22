with stg_goyoumeihosyo as (
    select
        rtrim(delflg, ' 　')::varchar(1) as delflg,
        rtrim(nyukono, ' 　')::varchar(9) as nyukono,
        rtrim(meisaino, ' 　')::varchar(4) as meisaino,
        rtrim(sainyukoymd, ' 　')::varchar(8) as sainyukoymd,
        rtrim(tyoushiukagaikekkacd, ' 　')::varchar(1) as tyoushiukagaikekkacd,
        rtrim(genincd, ' 　')::varchar(2) as genincd,
        rtrim(hosyokbn, ' 　')::varchar(2) as hosyokbn,
        rtrim(hosyoseikyusyono, ' 　')::varchar(12) as hosyoseikyusyono,
        rtrim(huguaisaigenumu, ' 　')::varchar(1) as huguaisaigenumu,
        rtrim(geninmeisyo, ' 　')::varchar(50) as geninmeisyo,
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3205') }}
)
select * from stg_goyoumeihosyo
where aggkey = 1
