{{
    config (
        post_hook=
            'create or replace hybrid table model_db.repair.dm_figbunkaiinfo (
                 ctlgcd varchar(6) not null,
                 figno varchar(4) not null,
                 bnkren4 varchar(4) not null,
                 hansno varchar(7) not null,
                 jissijikik varchar(6) not null,
                 jissijikim varchar(6) not null,
                 epckataptno varchar(6),
                 ilstcmtno varchar(5) not null,
                 katahgnjiki varchar(148),
                 ilstqty varchar(8),
                 langkbn varchar(3) not null,
                 figmei varchar(240),
                 bnkimgflmei varchar(8),
                 ilstcmt varchar(140),
                 ldts timestamp_ntz(9),
                 constraint dm_figbunkaiinfo_ctlgcd_figno_langkbn_bnkren4_hansno_jissijikik_jissijikim_ilstcmtno_uk primary key (ctlgcd, figno, langkbn, bnkren4, hansno, jissijikik, jissijikim, ilstcmtno) rely 
            ) as select * from {{this}}'
    )
}}

with
    tmp20_dm_figbunkaiinfo as (
        select * from {{ ref('tmp20_dm_figbunkaiinfo') }}
    ),
    stg_illustcomment as (
        select
            langkbn, -- 言語区分
            ilstcmtno, -- イラストコメントNO
            ilstcmt -- イラストコメント
        from {{ ref('stg_illustcomment') }} -- イラストコメント
    )
select
    tmp20_dm_figbunkaiinfo.*,
    stg_illustcomment.ilstcmt,
    current_timestamp::timestamp_ntz as ldts -- 作成日時
from tmp20_dm_figbunkaiinfo
inner join stg_illustcomment
  on tmp20_dm_figbunkaiinfo.ilstcmtno = stg_illustcomment.ilstcmtno
 and tmp20_dm_figbunkaiinfo.langkbn = stg_illustcomment.langkbn