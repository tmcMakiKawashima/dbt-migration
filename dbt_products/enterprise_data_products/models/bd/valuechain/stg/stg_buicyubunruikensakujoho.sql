with stg_buicyubunruikensakujoho as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        daibnrcd::varchar(4) as daibnrcd,
        chubnrcd::varchar(4) as chubnrcd,
        rtrim(hansno, ' 　')::varchar(7) as hansno,
        ldts,
        line_number,
        rank() over(partition by ctlgcd, daibnrcd, chubnrcd order by ldts desc, line_number desc) aggkey
    from {{ref('substr_k9jfv218')}}
)

select * exclude(mntkbn, line_number, aggkey) from stg_buicyubunruikensakujoho where aggkey = 1 and mntkbn in ('C', 'U')