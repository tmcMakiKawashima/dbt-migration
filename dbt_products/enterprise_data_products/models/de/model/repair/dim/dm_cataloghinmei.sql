{{
    config (
        post_hook=
            'create or replace hybrid table model_db.repair.dm_cataloghinmei (
                ctlgcd varchar(6) not null,
                syakata varchar(20) not null,
                syasyu_cd varchar(4) not null,
                jissijikik varchar(6) not null,
                jissijikim varchar(6) not null,
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
                syamei varchar(30),
                syameizen varchar(120),
                syameizenkana varchar(120),
                daikata varchar(50),
                seisank varchar(6),
                seisanm varchar(6),
                lexusflg varchar(1),
                prts1kbn varchar(1),
                tksyuflg varchar(1),
                langkbn varchar(3) not null,
                hinmeicd varchar(6) not null,
                hinban varchar(12) not null,
                kosu varchar(2) not null,
                siyoptno varchar(4) not null,
                epckataptno varchar(6) not null,
                kiricdk varchar(4) not null,
                kiricdm varchar(4) not null,
                trmcdmlt varchar(64) not null,
                clrcdmlt varchar(75) not null,
                tkstkbn varchar(1) not null,
                hktkgaikbn varchar(1) not null,
                hosemhin varchar(12) not null,
                srcflg varchar(1),
                tkkatahgn varchar(2048),
                siyocdmlt varchar(800),
                katanomlt varchar(1920),
                hinmei varchar(240),
                ldts timestamp_ntz(9),
                constraint dm_cataloghinmei_ctlgcd_syakata_syasyu_cd_katano_langkbn_hinmeicd_hinban_kosu_jissijikik_jissijikim_siyoptno_epckataptno_kiricdk_kiricdm_trmcdmlt_clrcdmlt_tkstkbn_hktkgaikbn_hosemhin_uk primary key (ctlgcd, syakata, syasyu_cd, katano, langkbn, hinmeicd, hinban, kosu, jissijikik, jissijikim, siyoptno, epckataptno, kiricdk, kiricdm, trmcdmlt, clrcdmlt, tkstkbn, hktkgaikbn, hosemhin) rely
            ) as select * from {{this}}'
    )
}}

with
    tmp20_dm_cataloghinmei as (
        select * from {{ ref('tmp20_dm_cataloghinmei') }}
    ),
    stg_hinmei as (
        select
            langkbn, -- 言語区分
            pnc, -- 品名コード
            hinmei -- 品名
        from {{ ref('stg_hinmei') }} -- 品名
    )
select
    tmp20_dm_cataloghinmei.*,
    stg_hinmei.hinmei,
    current_timestamp::timestamp_ntz as ldts -- 作成日時
from tmp20_dm_cataloghinmei
inner join stg_hinmei
  on tmp20_dm_cataloghinmei.langkbn = stg_hinmei.langkbn
 and tmp20_dm_cataloghinmei.hinmeicd = stg_hinmei.pnc