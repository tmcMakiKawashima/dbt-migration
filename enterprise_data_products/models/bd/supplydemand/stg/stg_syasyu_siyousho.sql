with stg_syasyu_siyousho as (
    select
        mtkbn::varchar(1) as mtkbn,
        syasyu::varchar(4) as syasyu,
        sno::varchar(2) as sno,
        jidokbn::varchar(1) as jidokbn,
        sktire::varchar(1) as sktire,
        skdoitu::varchar(1) as skdoitu,
        tokusyu::varchar(1) as tokusyu,
        syflg::varchar(1) as syflg,
        maesyasyu::varchar(4) as maesyasyu,
        tutisyo::varchar(3) as tutisyo,
        tutisuf::varchar(2) as tutisuf,
        lang::varchar(1) as lang,
        lang2::varchar(1) as lang2,
        mtdate::varchar(14) as mtdate,
        ldts::timestamp_ntz(9) as ldts,
        line_number,
        row_number() over (partition by syasyu, sno, ldts order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_ktrla024zz0ka21901')}}
)
select * exclude(mtkbn, line_number, aggkey)
from stg_syasyu_siyousho
where aggkey = 1 and mtkbn in ('C', 'U')