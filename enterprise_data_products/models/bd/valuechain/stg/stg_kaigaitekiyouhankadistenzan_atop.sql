with stg_kaigaitekiyouhankadistenzan_atop as (
    select
        rtrim(dist, ' 　')::varchar(5) as dist,
        rtrim(fdcd, ' 　')::varchar(2) as fdcd,
        iff(trim(tukacd, ' 　') = '',null,rtrim(tukacd, ' 　'))::varchar(1) as tukacd,
        iff(trim(enzansizin, ' 　') = '',null,to_decimal(to_decimal(enzansizin)/1000,4,3))::decimal(4,3) as enzansizin,
        iff(trim(enzansizio, ' 　') = '',null,to_decimal(to_decimal(enzansizio)/1000,4,3))::decimal(4,3) as enzansizio,
        iff(trim(eznsijikrkeymd, ' 　') = '',null,rtrim(eznsijikrkeymd, ' 　'))::varchar(8) as eznsijikrkeymd,
        iff(trim(rgncdn, ' 　') = '',null,rtrim(rgncdn, ' 　'))::varchar(3) as rgncdn,
        iff(trim(rgncdo, ' 　') = '',null,rtrim(rgncdo, ' 　'))::varchar(3) as rgncdo,
        iff(trim(rgncdkrkeymd, ' 　') = '',null,rtrim(rgncdkrkeymd, ' 　'))::varchar(8) as rgncdkrkeymd,
        iff(trim(tiikicd3, ' 　') = '',null,rtrim(tiikicd3, ' 　'))::varchar(3) as tiikicd3,
        iff(trim(torokuymd, ' 　') = '',null,rtrim(torokuymd, ' 　'))::varchar(8) as torokuymd,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                dist,fdcd
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m4') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m4') }})
)
select * exclude(aggkey)
from stg_kaigaitekiyouhankadistenzan_atop
where aggkey = 1