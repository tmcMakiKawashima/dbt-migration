with stg_goyoumei as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(nyukono, ' 　')::varchar(9) as nyukono,
        rtrim(meisaino, ' 　')::varchar(4) as meisaino,
        rtrim(hosyokbn, ' 　')::varchar(1) as hosyokbn,
        rtrim(t1w, ' 　')::varchar(4) as t1w,
        rtrim(goyomeisansyocd, ' 　')::varchar(10) as goyomeisansyocd,
        ldts,
        rank() over (partition by nyukono, meisaino order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3204') }}
)
select * from stg_goyoumei
where aggkey = 1
