with stg_buigroupkensakujoho as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        chubnrcd::varchar(4) as chubnrcd,
        svglayermei::varchar(4) as svglayermei,
        chuchubnrcd::varchar(4) as chuchubnrcd,
        ldts,
        line_number,
        rank() over(partition by ctlgcd, chubnrcd, svglayermei order by ldts desc, line_number desc) aggkey
    from {{ref('substr_k9jfv219')}}
)

select * exclude(mntkbn, line_number, aggkey) from stg_buigroupkensakujoho where aggkey = 1 and  mntkbn in ('C', 'U')