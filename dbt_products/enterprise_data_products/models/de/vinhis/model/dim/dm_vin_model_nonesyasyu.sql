{{
    config (
        post_hook=
            'create or replace hybrid table vinhis_db.model.dm_vin_model_nonesyasyu (
                 frmnokata varchar(7) not null,
                 frmno varchar(7) not null,
                 syasyu_cd varchar(4),
                 syakata varchar(20) not null,
                 mdlyearkbn varchar(1),
                 vin varchar(17),
                 nen varchar(4),
                 tuki varchar(2),
                 eng_type varchar(7),
                 transkata varchar(6),
                 rdf_type varchar(3),
                 clrcd varchar(3),
                 trmcd varchar(4),
                 siyoptno varchar(4),
                 tkstkbn varchar(1),
                 hanbai_kt varchar(20),
                 ctlgcd varchar(6),
                 jissijikik varchar(6),
                 jissijikim varchar(6),
                 katano varchar(3),
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
                 siyocd varchar(4),
                 dispseq varchar(3),
                 siyodaibnrmei varchar(320),
                 siyosaimokumei varchar(320),
                 ldts timestamp_ntz(6),
                 constraint dm_vin_model_nonesyasyu_frmnokata_frmno_syakata_langkbn_uk primary key (frmnokata, frmno, syakata, langkbn) rely 
            ) as select * from {{this}}'
    )
}}

with
    tmp20 as (
        select * from {{ ref('tmp20_dm_vin_model_nonesyasyu') }}
    ),
    syaryoshiyosobijoho as (
        select
            siyoptno, -- 仕様パターンNO
            langkbn, -- 言語区分
            siyocd, -- 仕様コード
            dispseq, -- 表示順序
            siyodaibnrmei, -- 仕様大分類名称
            siyosaimokumei, -- 仕様細目名称
            row_number() over (partition by langkbn, siyoptno order by ldts desc) aggkey
        from {{ ref('stg_syaryoshiyosobijoho') }} -- 車両仕様装備情報
    )
select
    tmp20.frmnokata as frmnokata, -- フレームNO型式
    tmp20.frmno as frmno, -- フレームNO
    tmp20.syasyu_cd as syasyu_cd, -- 車種コード
    tmp20.syakata as syakata, -- 車両型式
    tmp20.mdlyearkbn as mdlyearkbn, -- モデルイヤー区分
    tmp20.vin as vin, -- VIN(17桁)
    tmp20.nen as nen, -- 年
    tmp20.tuki as tuki, -- 月
    tmp20.eng_type as eng_type, -- エンジン型式
    tmp20.transkata as transkata, -- トランスミッション型式
    tmp20.rdf_type as rdf_type, -- リヤデフ型式
    tmp20.clrcd as clrcd, -- カラーコード
    tmp20.trmcd as trmcd, -- トリムコード
    tmp20.siyoptno as siyoptno, -- 仕様パターンNO
    tmp20.tkstkbn as tkstkbn, -- 特設区分
    tmp20.hanbai_kt as hanbai_kt, -- 販売型式
    tmp20.ctlgcd as ctlgcd, -- カタログコード
    tmp20.jissijikik as jissijikik, -- 実施時期カラ
    tmp20.jissijikim as jissijikim, -- 実施時期マデ
    tmp20.katano as katano, -- 型式NO
    tmp20.katatokukg1 as katatokukg1, -- 型式特徴記号1
    tmp20.katatokukg2 as katatokukg2, -- 型式特徴記号2
    tmp20.katatokukg3 as katatokukg3, -- 型式特徴記号3
    tmp20.katatokukg4 as katatokukg4, -- 型式特徴記号4
    tmp20.katatokukg5 as katatokukg5, -- 型式特徴記号5
    tmp20.katatokukg6 as katatokukg6, -- 型式特徴記号6
    tmp20.katatokukg7 as katatokukg7, -- 型式特徴記号7
    tmp20.katatokukg8 as katatokukg8, -- 型式特徴記号8
    tmp20.katatokukg9 as katatokukg9, -- 型式特徴記号9
    tmp20.katatokukg10 as katatokukg10, -- 型式特徴記号10
    tmp20.katatokukg11 as katatokukg11, -- 型式特徴記号11
    tmp20.katatokukg12 as katatokukg12, -- 型式特徴記号12
    tmp20.katatokukg13 as katatokukg13, -- 型式特徴記号13
    tmp20.katatokukg14 as katatokukg14, -- 型式特徴記号14
    tmp20.katatokukg15 as katatokukg15, -- 型式特徴記号15
    tmp20.katatokukg16 as katatokukg16, -- 型式特徴記号16
    tmp20.katatokukg17 as katatokukg17, -- 型式特徴記号17
    tmp20.katatokukg18 as katatokukg18, -- 型式特徴記号18
    tmp20.katatokukg19 as katatokukg19, -- 型式特徴記号19
    tmp20.katatokukg20 as katatokukg20, -- 型式特徴記号20
    tmp20.katatokukg21 as katatokukg21, -- 型式特徴記号21
    tmp20.katatokukg22 as katatokukg22, -- 型式特徴記号22
    tmp20.katatokukg23 as katatokukg23, -- 型式特徴記号23
    tmp20.syamei as syamei, -- 車名
    tmp20.syameizen as syameizen, -- 車名(全角)
    tmp20.syameizenkana as syameizenkana, -- 車名(全角)カナ
    tmp20.daikata as daikata, -- 代表型式
    tmp20.seisank as seisank, -- 生産年月カラ
    tmp20.seisanm as seisanm, -- 生産年月マデ
    tmp20.lexusflg as lexusflg, -- レクサス車フラグ
    tmp20.prts1kbn as prts1kbn, -- 1品番絞り込み区分
    tmp20.tksyuflg as tksyuflg, -- 特殊車フラグ
    syaryoshiyosobijoho.langkbn as langkbn, -- 言語区分
    syaryoshiyosobijoho.siyocd as siyocd, -- 仕様コード
    syaryoshiyosobijoho.dispseq as dispseq, -- 表示順序
    syaryoshiyosobijoho.siyodaibnrmei as siyodaibnrmei, -- 仕様大分類名称
    syaryoshiyosobijoho.siyosaimokumei as siyosaimokumei, -- 仕様細目名称
    current_timestamp::timestamp_ntz(6) as ldts -- 作成日時
from tmp20
inner join syaryoshiyosobijoho
  on tmp20.siyoptno = syaryoshiyosobijoho.siyoptno
where syaryoshiyosobijoho.aggkey = '1'