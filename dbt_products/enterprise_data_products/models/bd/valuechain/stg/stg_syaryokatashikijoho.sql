{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_syaryokatashikijoho (
                 ctlgcd varchar(6) not null,
                 syakata varchar(20) not null,
                 syasyu_cd varchar(4) not null,
                 vinwmivds varchar(9) not null,
                 jissijikik varchar(6),
                 jissijikim varchar(6),
                 frmnokata varchar(7),
                 katano varchar(3) not null,
                 katatokukg1 varchar(10),
                 katatokukg2 varchar(10),
                 katatokukg3 varchar(5),
                 katatokukg4 varchar(5),
                 katatokukg5 varchar(5),
                 katatokukg6 varchar(5),
                 katatokukg7 varchar(5),
                 katatokukg8 varchar(5),
                 katatokukg9 varchar(5),
                 katatokukg10 varchar(5),
                 katatokukg11 varchar(5),
                 katatokukg12 varchar(5),
                 katatokukg13 varchar(5),
                 katatokukg14 varchar(5),
                 katatokukg15 varchar(5),
                 katatokukg16 varchar(5),
                 katatokukg17 varchar(5),
                 katatokukg18 varchar(5),
                 katatokukg19 varchar(5),
                 katatokukg20 varchar(5),
                 katatokukg21 varchar(5),
                 katatokukg22 varchar(5),
                 katatokukg23 varchar(5),
                 ldts timestamp_ntz(9),
                 constraint stg_syaryokatashikijoho_ctlgcd_syakata_syasyu_cd_vinwmivds_katano_uk primary key (ctlgcd, syakata, syasyu_cd, vinwmivds, katano) rely 
            ) as select * from {{this}}'
    )
}}
-- ハイブリッドテーブルに変更

with stg_syaryokatashikijoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(ctlgcd, ' 　')::varchar(6) as ctlgcd, -- 右blank
        rtrim(syakata, ' 　')::varchar(20) as syakata, -- 右blank
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, -- 右blank
        rtrim(vinwmivds, ' 　')::varchar(9) as vinwmivds, -- 右blank
        rtrim(jissijikik, ' 　')::varchar(6) as jissijikik, -- 右blank
        rtrim(jissijikim, ' 　')::varchar(6) as jissijikim, -- 右blank
        frmnokata::varchar(7) as frmnokata, 
        rtrim(katano, ' 　')::varchar(3) as katano, -- 右blank
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