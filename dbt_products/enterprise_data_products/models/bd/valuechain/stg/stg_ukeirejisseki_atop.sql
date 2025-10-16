with stg_ukeirejisseki_atop as (
    select
        syoritype::varchar(1) as syoritype,
        uketukeymd::varchar(8) as uketukeymd,
        uketuketime::varchar(17) as uketuketime,
        dataid::varchar(4) as dataid,
        tyohyono::varchar(4) as tyohyono,
        ukeirecd::varchar(2) as ukeirecd,
        nnkyotnkbn::varchar(1) as nnkyotnkbn,
        kaknokyotnkbn::varchar(1) as kaknokyotnkbn,
        tyotathb::varchar(20) as tyotathb,
        srsirskcd::varchar(4) as srsirskcd,
        brsirskcd::varchar(4) as brsirskcd,
        kanbnkbn::varchar(1) as kanbnkbn,
        to_decimal(nsinnsu,6,0)::decimal(6,0) as nsinnsu,
        to_decimal(teiseisu,5,0)::decimal(5,0) as teiseisu,
        nnyoteibi::varchar(2) as nnyoteibi,
        nnymd::varchar(8) as nnymd,
        motikomisk::varchar(4) as motikomisk,
        tcksyrbi::varchar(8) as tcksyrbi,
        tckyomitritime::varchar(4) as tckyomitritime,
        inputbasyocd::varchar(2) as inputbasyocd,
        nnbangou::varchar(5) as nnbangou,
        kiban::varchar(2) as kiban,
        syrrenbn::varchar(5) as syrrenbn,
        r1kbn::varchar(1) as r1kbn,
        cardno::varchar(1) as cardno,
        nnbin::varchar(2) as nnbin,
        srsirskkojocd::varchar(1) as srsirskkojocd,
        srsirsksykajocd::varchar(3) as srsirsksykajocd,
        brsirskkojocd::varchar(1) as brsirskkojocd,
        brsirsksykajocd::varchar(3) as brsirsksykajocd,
        tcknnbi::varchar(6) as tcknnbi,
        tcknnbin::varchar(2) as tcknnbin,
        uketukeflg::varchar(1) as uketukeflg,
        syrkekaflg::varchar(1) as syrkekaflg,
        zikhneiumu::varchar(1) as zikhneiumu,
        jissekkejyumu::varchar(1) as jissekkejyumu,
        ukterrflg::varchar(2) as ukterrflg,
        kknkigusyosu::varchar(7) as kknkigusyosu,
        sgyloke::varchar(10) as sgyloke,
        nonyutni::varchar(5) as nonyutni,
        hosobasyokbn::varchar(1) as hosobasyokbn,
        hososyubicd::varchar(2) as hososyubicd,
        orosibacd::varchar(2) as orosibacd,
        errmsg::varchar(19) as errmsg,
        try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF6') as mttime,
        filler::varchar(63) as filler,
        ldts,
        row_number() over (
            partition by 
                kaknokyotnkbn,tyotathb,srsirskcd,brsirskcd,nnymd
            order by line_number desc
        ) aggkey
        from {{ ref('substr_ktrla01vzz0kvr00qe') }}
        where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvr00qe') }})
)
select * exclude(aggkey)
from stg_ukeirejisseki_atop
where aggkey = 1