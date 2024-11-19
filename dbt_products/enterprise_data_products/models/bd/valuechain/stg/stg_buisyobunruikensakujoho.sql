with stg_buisyobunruikensakujoho as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        chubnrcd::varchar(4) as chubnrcd,
        svglayermei::varchar(4) as svglayermei,
        figno::varchar(4) as figno,
        rtrim(hansno,' 　')::varchar(7) as hansno,
        emkjimgflmei::varchar(20) as emkjimgflmei,
        fignotaiouflg::varchar(1) as fignotaiouflg,
        ldts,
        line_number,
        rank() over(partition by ctlgcd, chubnrcd, svglayermei, figno order by ldts desc, mntkbn asc, line_number desc) aggkey
    from {{ref('substr_k9jfv220')}}
)

select * exclude(line_number, aggkey) from stg_buisyobunruikensakujoho where aggkey = 1