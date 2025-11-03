with stg_syoruihanyo_atop as (
    select
        rtrim(srihnymtkey, ' 　')::varchar(3) as srihnymtkey,
        rtrim(srihanyomstkey, ' 　')::varchar(27) as srihanyomstkey,
        iff(trim(srihnymtdata, ' 　') = '',null,rtrim(srihnymtdata, ' 　'))::varchar(234) as srihnymtdata,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                srihnymtkey,srihanyomstkey
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvp00q2') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvp00q2') }})
)
select * exclude(aggkey)
from stg_syoruihanyo_atop
where aggkey = 1