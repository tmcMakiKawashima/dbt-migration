with stg_syaryomodelshikibetsu_atop as (
    select
        rtrim(hinban, ' 　')::varchar(20) as hinban,
        rtrim(tiikigrpcd, ' 　')::varchar(1) as tiikigrpcd,
        iff(trim(pfcdn, ' 　') = '',null,rtrim(pfcdn, ' 　'))::varchar(2) as pfcdn,
        iff(trim(pfcdo, ' 　') = '',null,rtrim(pfcdo, ' 　'))::varchar(2) as pfcdo,
        iff(trim(pfcdkrkeymd, ' 　') = '',null,rtrim(pfcdkrkeymd, ' 　'))::varchar(8) as pfcdkrkeymd,
        iff(trim(zidoskskbn, ' 　') = '',null,rtrim(zidoskskbn, ' 　'))::varchar(1) as zidoskskbn,
        iff(trim(torokuymd, ' 　') = '',null,rtrim(torokuymd, ' 　'))::varchar(8) as torokuymd,
        iff(trim(mdlskicom, ' 　') = '',null,rtrim(mdlskicom, ' 　'))::varchar(20) as mdlskicom,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                hinban,tiikigrpcd
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m6') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m6') }})
)
select * exclude(aggkey)
from stg_syaryomodelshikibetsu_atop
where aggkey = 1