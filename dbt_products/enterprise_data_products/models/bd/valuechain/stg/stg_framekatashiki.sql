{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_framekatashiki (
                 frmnokata varchar(7) not null,
                 frmno varchar(7) not null,
                 mdlyearkbn varchar(1) not null,
                 vin varchar(17) not null,
                 nen varchar(4),
                 tuki varchar(2),
                 clrcd varchar(3),
                 trmcd varchar(4),
                 syasyu_cd varchar(4),
                 siyoptno varchar(4),
                 tkstkbn varchar(1),
                 syakata varchar(20),
                 hanbai_kt varchar(20),
                 eng_type varchar(7),
                 transkata varchar(6),
                 rdf_type varchar(3),
                 ldts timestamp_ntz(9),
                 constraint stg_framekatashiki_frmnokata_frmno_mdlyearkbn_vin_uk primary key (frmnokata, frmno, mdlyearkbn, vin) rely 
             ) as select * from  {{this}}'
    )
}}

with stg_framekatashiki as (
    select
        mntkbn::varchar(1) as mntkbn, 
        frmnokata::varchar(7) as frmnokata, 
        replace(frmno, '@', '0')::varchar(7) as frmno, 
        mdlyearkbn::varchar(1) as mdlyearkbn, 
        vin::varchar(17) as vin, 
        nen::varchar(4) as nen, 
        tuki::varchar(2) as tuki, 
        clrcd::varchar(3) as clrcd, 
        trmcd::varchar(4) as trmcd, 
        syasyu_cd::varchar(4) as syasyu_cd, 
        siyoptno::varchar(4) as siyoptno, 
        tkstkbn::varchar(1) as tkstkbn, 
        syakata::varchar(20) as syakata, 
        hanbai_kt::varchar(20) as hanbai_kt, 
        eng_type::varchar(7) as eng_type, 
        transkata::varchar(6) as transkata, 
        rdf_type::varchar(3) as rdf_type, 
        ldts, --B層取込日時
        rank() over (partition by frmnokata, frmno, mdlyearkbn, vin order by ldts desc) aggkey
    from {{ ref('substr_dv2a5404') }}
)
select * exclude(mntkbn, aggkey)
from stg_framekatashiki
where aggkey = 1 and mntkbn in ('C', 'U')