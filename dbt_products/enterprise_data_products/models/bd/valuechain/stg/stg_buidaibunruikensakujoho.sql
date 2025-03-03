with stg_buidaibunruikensakujoho as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        daibnrcd::varchar(4) as daibnrcd,
        rtrim(hansno, ' 　')::varchar(7) as hansno,
        ldts,
        line_number,
        rank() over(partition by ctlgcd, daibnrcd order by ldts desc, mntkbn asc, line_number desc) aggkey
    from {{ref('substr_k9jfv217')}}
)
select * exclude(line_number, aggkey) from stg_buidaibunruikensakujoho where aggkey = 1