with stg_kaigaitekiyouhankafobshisuu_atop as (
    select
        rtrim(rgncd3, ' 　')::varchar(3) as rgncd3,
        rtrim(oprccls, ' 　')::varchar(3) as oprccls,
        iff(trim(fobsisun, ' 　') = '',null,to_decimal(to_decimal(fobsisun)/1000,5,3))::decimal(5,3) as fobsisun,
        iff(trim(fobsisuo, ' 　') = '',null,to_decimal(to_decimal(fobsisuo)/1000,5,3))::decimal(5,3) as fobsisuo,
        iff(trim(fobsisukrkeymd, ' 　') = '',null,to_date(fobsisukrkeymd,'YYYYMMDD')) as fobsisukrkeymd,
        iff(trim(torokuymd, ' 　') = '',null,to_date(torokuymd,'YYYYMMDD')) as torokuymd,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                rgncd3,oprccls
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m5') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m5') }})
)
select * exclude(aggkey)
from stg_kaigaitekiyouhankafobshisuu_atop
where aggkey = 1