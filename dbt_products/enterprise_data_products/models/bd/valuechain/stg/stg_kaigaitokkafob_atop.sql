with stg_kaigaitokkafob_atop as (
    select
        rtrim(hinban, ' 　')::varchar(20) as hinban,
        rtrim(dist, ' 　')::varchar(5) as dist,
        rtrim(fdcd, ' 　')::varchar(2) as fdcd,
        iff(trim(tekiyokaisiymd, ' 　') = '',null,rtrim(tekiyokaisiymd, ' 　'))::varchar(8) as tekiyokaisiymd,
        iff(trim(tekiyosyuryoymd, ' 　') = '',null,rtrim(tekiyosyuryoymd, ' 　'))::varchar(8) as tekiyosyuryoymd,
        iff(trim(tokafob, ' 　') = '',null,to_decimal(to_decimal(tokafob)/100,11,2))::decimal(11,2) as tokafob,
        iff(trim(tokkasyurui, ' 　') = '',null,rtrim(tokkasyurui, ' 　'))::varchar(2) as tokkasyurui,
        iff(trim(busyocd, ' 　') = '',null,rtrim(busyocd, ' 　'))::varchar(5) as busyocd,
        iff(trim(juchucnt, ' 　') = '',null,rtrim(juchucnt, ' 　'))::varchar(10) as juchucnt,
        iff(trim(sakuseikbn, ' 　') = '',null,rtrim(sakuseikbn, ' 　'))::varchar(1) as sakuseikbn,
        iff(trim(kgispfobcom, ' 　') = '',null,rtrim(kgispfobcom, ' 　'))::varchar(20) as kgispfobcom,
        iff(trim(torokuymd, ' 　') = '',null,rtrim(torokuymd, ' 　'))::varchar(8) as torokuymd,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                hinban,dist,fdcd
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m3') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m3') }})
)
select * exclude(aggkey)
from stg_kaigaitokkafob_atop
where aggkey = 1