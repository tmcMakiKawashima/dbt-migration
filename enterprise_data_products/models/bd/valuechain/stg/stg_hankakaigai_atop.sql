with stg_hankakaigai_atop as (
    select
        rtrim(hinban, ' 　')::varchar(20) as hinban,
        iff(trim(tekiyokaisiymd, ' 　') = '',null,to_date(tekiyokaisiymd,'YYYYMMDD')) as tekiyokaisiymd,
        iff(trim(tekiyosyuryoymd, ' 　') = '',null,to_date(tekiyosyuryoymd,'YYYYMMDD')) as tekiyosyuryoymd,
        iff(trim(oprccls, ' 　') = '',null,rtrim(oprccls, ' 　'))::varchar(3) as oprccls,
        iff(trim(hnkkihonfob, ' 　') = '',null,to_decimal(hnkkihonfob,8,0))::decimal(8,0) as hnkkihonfob,
        iff(trim(sagyoriyucd, ' 　') = '',null,rtrim(sagyoriyucd, ' 　'))::varchar(1) as sagyoriyucd,
        iff(trim(henkoriyucd, ' 　') = '',null,rtrim(henkoriyucd, ' 　'))::varchar(2) as henkoriyucd,
        iff(trim(seisankyoku, ' 　') = '',null,rtrim(seisankyoku, ' 　'))::varchar(3) as seisankyoku,
        iff(trim(hanbaiktrtry, ' 　') = '',null,rtrim(hanbaiktrtry, ' 　'))::varchar(3) as hanbaiktrtry,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                hinban
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m2') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m2') }})
)
select * exclude(aggkey)
from stg_hankakaigai_atop
where aggkey = 1