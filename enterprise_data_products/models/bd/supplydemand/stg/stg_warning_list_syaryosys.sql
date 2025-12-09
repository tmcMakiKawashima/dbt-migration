with stg_warning_list_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        hknisu::number(4,1) as hknisu,
        hksa::number(4,1) as hksa,
        yrnisu::number(3,0) as yrnisu,
        yrdaisu::number(8,0) as yrdaisu,
        tare::number(3,0) as tare,
        try_to_date(saisou, 'yyyymmdd') as saisou,
        try_to_date(saiti, 'yyyymmdd') as saiti,
        codai::number(5,0) as codai,
        yoyu::number(5,0) as yoyu,
        kari::number(5,0) as kari,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shamei, sno
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('subtsr_tsjfa36h')}}
    where ldts = (select max(ldts) from {{ref('subtsr_tsjfa36h')}})
)
select * exclude(aggkey)
from stg_warning_list_syaryosys
where aggkey = 1