with stg_kinobetsu_noryoku_waku_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        yyyymm::varchar(6) as yyyymm,
        kncode::varchar(7) as kncode,
        to_decimal(iff(rtrim(free_flag, ' 　') = '', 0, rtrim(free_flag, ' 　')))::decimal(1,0) as free_flag,
        knkbn::varchar(1) as knkbn,
        kbn::number(1,0) as kbn,
        d01::number(5,0) as d01,
        d02::number(5,0) as d02,
        d03::number(5,0) as d03,
        d04::number(5,0) as d04,
        d05::number(5,0) as d05,
        d06::number(5,0) as d06,
        d07::number(5,0) as d07,
        d08::number(5,0) as d08,
        d09::number(5,0) as d09,
        d10::number(5,0) as d10,
        d11::number(5,0) as d11,
        d12::number(5,0) as d12,
        d13::number(5,0) as d13,
        d14::number(5,0) as d14,
        d15::number(5,0) as d15,
        d16::number(5,0) as d16,
        d17::number(5,0) as d17,
        d18::number(5,0) as d18,
        d19::number(5,0) as d19,
        d20::number(5,0) as d20,
        d21::number(5,0) as d21,
        d22::number(5,0) as d22,
        d23::number(5,0) as d23,
        d24::number(5,0) as d24,
        d25::number(5,0) as d25,
        d26::number(5,0) as d26,
        d27::number(5,0) as d27,
        d28::number(5,0) as d28,
        d29::number(5,0) as d29,
        d30::number(5,0) as d30,
        d31::number(5,0) as d31,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shamei, sno, kncode, kbn, yyyymm
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa369')}}
    where ldts = (select max(ldts) from {{ref('substr_tsjfa369')}})
)
select * exclude(aggkey)
from stg_kinobetsu_noryoku_waku_syaryosys
where aggkey = 1