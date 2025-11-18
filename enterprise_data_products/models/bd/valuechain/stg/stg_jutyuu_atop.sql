with stg_jutyuu_atop as (
    select
        rtrim(jhinban, ' 　')::varchar(20) as jhinban,
        iff(rtrim(siyouhenk, ' 　') = '', null, rtrim(siyouhenk, ' 　'))::varchar(1) as siyouhenk,
        iff(rtrim(gohuzis, ' 　') = '', null, rtrim(gohuzis, ' 　'))::varchar(1) as gohuzis,
        iff(rtrim(gomizis, ' 　') = '', null, rtrim(gomizis, ' 　'))::varchar(1) as gomizis,
        iff(rtrim(noservkbn, ' 　') = '', null, rtrim(noservkbn, ' 　'))::varchar(1) as noservkbn,
        iff(rtrim(tkbtjuchutyusi, ' 　') = '', null, rtrim(tkbtjuchutyusi, ' 　'))::varchar(1) as tkbtjuchutyusi,
        iff(rtrim(seskhuka, ' 　') = '', null, rtrim(seskhuka, ' 　'))::varchar(1) as seskhuka,
        to_decimal(iff(rtrim(tanchk, ' 　') = '', null, rtrim(tanchk, ' 　')))::number(3,0) as tanchk,
        iff(rtrim(ctlgmskbn, ' 　') = '', null, rtrim(ctlgmskbn, ' 　'))::varchar(1) as ctlgmskbn,
        iff(rtrim(hanbaityusi, ' 　') = '', null, rtrim(hanbaityusi, ' 　'))::varchar(1) as hanbaityusi,
        iff(rtrim(anznyo, ' 　') = '', null, rtrim(anznyo, ' 　'))::varchar(1) as anznyo,
        iff(rtrim(wariyoflg, ' 　') = '', null, rtrim(wariyoflg, ' 　'))::varchar(1) as wariyoflg,
        iff(rtrim(kgigntsyukka, ' 　') = '', null, rtrim(kgigntsyukka, ' 　'))::varchar(1) as kgigntsyukka,
        iff(rtrim(kgignt, ' 　') = '', null, rtrim(kgignt, ' 　'))::varchar(8) as kgignt,
        iff(rtrim(tkskbn, ' 　') = '', null, rtrim(tkskbn, ' 　'))::varchar(1) as tkskbn,
        iff(rtrim(mtuserid, ' 　') = '', null, rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(rtrim(mttime, ' 　') = '', null, to_timestamp_ntz(rtrim(mttime, ' 　'), 'yyyy-mm-dd-hh24.mi.ss.ff6'))::timestamp_ntz(9) as mttime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by jhinban
            order by line_number desc
        ) aggkey 
    from
        {{ref('substr_ktrla01vzz0kvs00m2')}}
    where
        ldts = (select max(ldts) from {{ref('substr_ktrla01vzz0kvs00m2')}})
)
select * exclude(aggkey) from stg_jutyuu_atop
where aggkey = 1