with stg_syaryokatashikijoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        ctlgcd::varchar(6) as ctlgcd, 
        syakata::varchar(20) as syakata, 
        syasyu_cd::varchar(4) as syasyu_cd, 
        vinwmivds::varchar(9) as vinwmivds, 
        jissijikik::varchar(6) as jissijikik, 
        jissijikim::varchar(6) as jissijikim, 
        frmnokata::varchar(7) as frmnokata, 
        katano::varchar(3) as katano, 
        katatokukg1::varchar(10) as katatokukg1, 
        katatokukg2::varchar(10) as katatokukg2, 
        katatokukg3::varchar(5) as katatokukg3, 
        katatokukg4::varchar(5) as katatokukg4, 
        katatokukg5::varchar(5) as katatokukg5, 
        katatokukg6::varchar(5) as katatokukg6, 
        katatokukg7::varchar(5) as katatokukg7, 
        katatokukg8::varchar(5) as katatokukg8, 
        katatokukg9::varchar(5) as katatokukg9, 
        katatokukg10::varchar(5) as katatokukg10, 
        katatokukg11::varchar(5) as katatokukg11, 
        katatokukg12::varchar(5) as katatokukg12, 
        katatokukg13::varchar(5) as katatokukg13, 
        katatokukg14::varchar(5) as katatokukg14, 
        katatokukg15::varchar(5) as katatokukg15, 
        katatokukg16::varchar(5) as katatokukg16, 
        katatokukg17::varchar(5) as katatokukg17, 
        katatokukg18::varchar(5) as katatokukg18, 
        katatokukg19::varchar(5) as katatokukg19, 
        katatokukg20::varchar(5) as katatokukg20, 
        katatokukg21::varchar(5) as katatokukg21, 
        katatokukg22::varchar(5) as katatokukg22, 
        katatokukg23::varchar(5) as katatokukg23, 
        ldts, --B層取込日時
        rank() over (partition by ctlgcd, syakata, syasyu_cd, vinwmivds, katano order by ldts desc) aggkey
    from {{ ref('substr_dv2a4974') }}
)
select * exclude(mntkbn, aggkey)
from stg_syaryokatashikijoho
where aggkey = 1 and mntkbn in ('C', 'U')