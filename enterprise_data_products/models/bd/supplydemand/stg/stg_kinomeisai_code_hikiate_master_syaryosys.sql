with stg_kinomeisai_code_hikiate_master_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        kncode::varchar(7) as kncode,
        to_decimal(iff(rtrim(odt, ' 　') = '', 0, rtrim(odt, ' 　')))::decimal(1,0) as odt,
        nisgta::varchar(1) as nisgta,
        smka::varchar(3) as smka,
        ckataa::varchar(20) as ckataa,
        gaicda::varchar(4) as gaicda,
        ucda::varchar(4) as ucda,
        sspeckkigo_area_g::varchar(80) as sspeckkigo_area_g,
        to_decimal(iff(rtrim(nrknrflg, ' 　') = '', 0, rtrim(nrknrflg, ' 　')))::decimal(1,0) as nrknrflg,
        to_decimal(iff(rtrim(nrkensyoflg, ' 　') = '', 0, rtrim(nrkensyoflg, ' 　')))::decimal(1,0) as nrkensyoflg,
        creymd::varchar(8) as creymd,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shamei, sno, kncode
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla01dzz0kalc016')}}
    where ldts = (select max(ldts) from {{ref('substr_ktrla01dzz0kalc016')}})
)
select * exclude(aggkey)
from stg_kinomeisai_code_hikiate_master_syaryosys
where aggkey = 1