with stg_syoruihinbankihon_atop as (
    select
        rtrim(shinban, ' 　')::varchar(20) as shinban,
        iff(trim(hanbaikbn, ' 　') = '',null,rtrim(hanbaikbn, ' 　'))::varchar(1) as hanbaikbn,
        iff(trim(syukancd, ' 　') = '',null,rtrim(syukancd, ' 　'))::varchar(1) as syukancd,
        iff(trim(tokeibricd, ' 　') = '',null,rtrim(tokeibricd, ' 　'))::varchar(3) as tokeibricd,
        iff(trim(jukenkbn, ' 　') = '',null,rtrim(jukenkbn, ' 　'))::varchar(1) as jukenkbn,
        iff(trim(raisenscd, ' 　') = '',null,rtrim(raisenscd, ' 　'))::varchar(1) as raisenscd,
        iff(trim(menzeikbn, ' 　') = '',null,rtrim(menzeikbn, ' 　'))::varchar(1) as menzeikbn,
        iff(trim(zaisitcd, ' 　') = '',null,rtrim(zaisitcd, ' 　'))::varchar(40) as zaisitcd,
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
    from {{ ref('substr_ktrla01vzz0kvs00m0') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvs00m0') }})
)
select * exclude(aggkey)
from stg_syoruihinbankihon_atop
where aggkey = 1