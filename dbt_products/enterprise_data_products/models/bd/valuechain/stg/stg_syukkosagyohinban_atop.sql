
with stg_syukkosagyohinban_atop as (
    select
        rtrim(shinban, ' 　')::varchar(20) as shinban,
        rtrim(kaknoukbn, ' 　')::varchar(1) as kaknoukbn,
        iff(rtrim(situryog8, ' 　') = '', null, to_decimal(situryog8)/10)::number(8,1) as situryog8,
        iff(rtrim(yoseki3, ' 　') = '', null, to_decimal(yoseki3)/10)::number(10,1) as yoseki3,
        iff(rtrim(yosekss, ' 　') = '', null, to_decimal(yosekss))::number(2,0) as yosekss,
        iff(rtrim(sizel, ' 　') = '', null, to_decimal(sizel))::number(4,0) as sizel,
        iff(rtrim(sizew, ' 　') = '', null, to_decimal(sizew))::number(4,0) as sizew,
        iff(rtrim(sizeh, ' 　') = '', null, to_decimal(sizeh))::number(4,0) as sizeh,
        iff(rtrim(ssnjuryo, ' 　') = '', null, to_decimal(ssnjuryo)/10)::number(5,1) as ssnjuryo,
        to_date(iff(rtrim(tekiyokaisiymd, ' 　') = '', null, tekiyokaisiymd), 'yyyymmdd')::date as tekiyokaisiymd,
        to_date(iff(rtrim(tekiyosyuryoymd, ' 　') = '', null, tekiyosyuryoymd), 'yyyymmdd')::date as tekiyosyuryoymd,
        iff(rtrim(mtuserid, ' 　') = '', null, rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        to_timestamp_ntz(iff(rtrim(mttime, ' 　') = '', null, mttime), 'yyyy-mm-dd-hh24.mi.ss.ff6')::timestamp_ntz(9) as mttime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shinban, kaknoukbn
            order by line_number desc
        ) aggkey 
    from {{ref('substr_ktrla01vzz0kvs00m5')}}
    where ldts = (select max(ldts) from {{ref('substr_ktrla01vzz0kvs00m5')}})
)
select * exclude(aggkey) from stg_syukkosagyohinban_atop
where aggkey = 1