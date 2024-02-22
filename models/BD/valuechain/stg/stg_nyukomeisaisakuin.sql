with stg_nyukomeisaisakuin as (
    select
        rtrim(delflg, ' 　')::varchar(1) as delflg,
        rtrim(nyukohanbaitencd, ' 　')::varchar(5) as nyukohanbaitencd,
        rtrim(jutyuno, ' 　')::varchar(8) as jutyuno,
        rtrim(seisany, ' 　')::varchar(4) as seisany,
        rtrim(seisanmd, ' 　')::varchar(4) as seisanmd,
        seisany||seisanmd::varchar(8) as seisanymd,
        rtrim(nyukono, ' 　')::varchar(9) as nyukono,
        ldts,
        rank() over (partition by nyukohanbaitencd, jutyuno, seisany, seisanmd, nyukono order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3203') }}
)
select * from stg_nyukomeisaisakuin
where aggkey = 1
