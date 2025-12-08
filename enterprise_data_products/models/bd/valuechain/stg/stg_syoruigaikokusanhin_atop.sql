with stg_syoruigaikokusanhin_atop as (
    select
        rtrim(shinban, ' 　')::varchar(20) as shinban,
        iff(trim(gnsnktrkkanryst, ' 　') = '',null,rtrim(gnsnktrkkanryst, ' 　'))::varchar(1) as gnsnktrkkanryst,
        iff(trim(gaikoksngaihkbn, ' 　') = '',null,rtrim(gaikoksngaihkbn, ' 　'))::varchar(1) as gaikoksngaihkbn,
        iff(trim(seisnkaisyamei, ' 　') = '',null,rtrim(seisnkaisyamei, ' 　'))::varchar(40) as seisnkaisyamei,
        iff(trim(gensnkmei, ' 　') = '',null,rtrim(gensnkmei, ' 　'))::varchar(20) as gensnkmei,
        iff(trim(tekiyokaisiymd, ' 　') = '',null,to_date(tekiyokaisiymd,'YYYYMMDD')) as tekiyokaisiymd,
        iff(trim(tekiyosyuryoymd, ' 　') = '',null,to_date(tekiyosyuryoymd,'YYYYMMDD')) as tekiyosyuryoymd,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                shinban
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvs00m4') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvs00m4') }})
)
select * exclude(aggkey)
from stg_syoruigaikokusanhin_atop
where aggkey = 1