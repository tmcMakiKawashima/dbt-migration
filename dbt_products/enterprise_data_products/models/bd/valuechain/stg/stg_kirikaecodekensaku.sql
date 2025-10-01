{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_kirikaecodekensaku (
                 ctlgcd varchar(6) not null,
                 kiricd varchar(4) not null,
                 prtren varchar(3) not null,
                 datakbn varchar(1),
                 frmnok varchar(20),
                 frmnom varchar(20),
                 pltno varchar(20),
                 ldts timestamp_ntz(9),
                 constraint stg_kirikaecodekensaku_ctlgcd_kiricd_prtren_uk primary key (ctlgcd, kiricd, prtren) rely 
            ) as select * from {{this}}'
    )
}}
-- ハイブリッドテーブルに変更

with stg_kirikaecodekensaku as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(ctlgcd, ' 　')::varchar(6) as ctlgcd, -- 右blank
        rtrim(kiricd, ' 　')::varchar(4) as kiricd, -- 右blank
        rtrim(prtren, ' 　')::varchar(3) as prtren, -- 右blank
        datakbn::varchar(1) as datakbn, 
        frmnok::varchar(20) as frmnok, 
        frmnom::varchar(20) as frmnom, 
        pltno::varchar(20) as pltno, 
        ldts, --B層取込日時
        rank() over (partition by ctlgcd, kiricd, prtren order by ldts desc) aggkey
    from {{ ref('substr_dv2a3704') }}
)
select * exclude(mntkbn, aggkey)
from stg_kirikaecodekensaku
where aggkey = 1 and mntkbn in ('C', 'U')