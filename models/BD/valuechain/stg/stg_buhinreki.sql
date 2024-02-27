with stg_buhinreki as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(nyukono, ' 　')::varchar(9) as nyukono,
        rtrim(meisaino, ' 　')::varchar(4) as meisaino,
        rtrim(buhinsuryo, ' 　')::varchar(4) as buhinsuryo,
        rtrim(buhinmeisyosansyocd, ' 　')::varchar(11) as buhinmeisyosansyocd,
        rtrim(hinban, ' 　')::varchar(15) as hinban,
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3207') }}
)
select * from stg_buhinreki
where aggkey = 1
