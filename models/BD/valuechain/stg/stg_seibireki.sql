with stg_seibireki as (
    select
        rtrim(delflg, ' 　')::varchar(1) as delflg,
        rtrim(nyukono, ' 　')::varchar(9) as nyukono,
        rtrim(meisaino, ' 　')::varchar(4) as meisaino,
        rtrim(sobinamesansyocd, ' 　')::varchar(11) as sobinamesansyocd,
        rtrim(seibicd, ' 　')::varchar(8) as seibicd,
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3206') }}
)
select * from stg_seibireki
where aggkey = 1
