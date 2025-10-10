with stg_kaigaitekiyouhankakawasetsuuka_atop as (
    select
        rtrim(tukacd, ' 　')::varchar(1) as tukacd,
        iff(trim(kawaseraten, ' 　') = '',null,to_decimal(to_decimal(kawaseraten)/100,7,2))::decimal(7,2) as kawaseraten,
        iff(trim(kawaserateo, ' 　') = '',null,to_decimal(to_decimal(kawaserateo)/100,7,2))::decimal(7,2) as kawaserateo,
        iff(trim(kwsratekrkeymd, ' 　') = '',null,rtrim(kwsratekrkeymd, ' 　'))::varchar(8) as kwsratekrkeymd,
        iff(trim(tukacdmei, ' 　') = '',null,rtrim(tukacdmei, ' 　'))::varchar(10) as tukacdmei,
        iff(trim(tukakigo, ' 　') = '',null,rtrim(tukakigo, ' 　'))::varchar(2) as tukakigo,
        iff(trim(syohenkbn, ' 　') = '',null,rtrim(syohenkbn, ' 　'))::varchar(1) as syohenkbn,
        iff(trim(torokuymd, ' 　') = '',null,rtrim(torokuymd, ' 　'))::varchar(8) as torokuymd,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                tukacd
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m7') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m7') }})
)
select * exclude(aggkey)
from stg_kaigaitekiyouhankakawasetsuuka_atop
where aggkey = 1