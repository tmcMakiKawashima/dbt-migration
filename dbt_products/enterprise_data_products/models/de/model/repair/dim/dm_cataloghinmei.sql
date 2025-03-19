{{
    config (
        materialized='view'
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
    tmp20_dm_cataloghinmei.ctlgcd,
    tmp20_dm_cataloghinmei.syakata,
    tmp20_dm_cataloghinmei.syasyu_cd,
    tmp20_dm_cataloghinmei.jissijikik,
    tmp20_dm_cataloghinmei.jissijikim,
    tmp20_dm_cataloghinmei.frmnokata,
    tmp20_dm_cataloghinmei.katano,
    tmp20_dm_cataloghinmei.katatokukg1,
    tmp20_dm_cataloghinmei.katatokukg2,
    tmp20_dm_cataloghinmei.katatokukg3,
    tmp20_dm_cataloghinmei.katatokukg4,
    tmp20_dm_cataloghinmei.katatokukg5,
    tmp20_dm_cataloghinmei.katatokukg6,
    tmp20_dm_cataloghinmei.katatokukg7,
    tmp20_dm_cataloghinmei.syamei,
    tmp20_dm_cataloghinmei.syameizen,
    tmp20_dm_cataloghinmei.syameizenkana,
    tmp20_dm_cataloghinmei.daikata,
    tmp20_dm_cataloghinmei.seisank,
    tmp20_dm_cataloghinmei.seisanm,
    tmp20_dm_cataloghinmei.lexusflg,
    tmp20_dm_cataloghinmei.prts1kbn,
    tmp20_dm_cataloghinmei.tksyuflg,
    tmp20_dm_cataloghinmei.langkbn,
    tmp20_dm_cataloghinmei.hinmeicd,
    tmp20_dm_cataloghinmei.hinban,
    tmp20_dm_cataloghinmei.kosu,
    tmp20_dm_cataloghinmei.siyoptno,
    tmp20_dm_cataloghinmei.epckataptno,
    tmp20_dm_cataloghinmei.kiricdk,
    tmp20_dm_cataloghinmei.kiricdm,
    tmp20_dm_cataloghinmei.trmcdmlt,
    tmp20_dm_cataloghinmei.clrcdmlt,
    tmp20_dm_cataloghinmei.tkstkbn,
    tmp20_dm_cataloghinmei.hktkgaikbn,
    tmp20_dm_cataloghinmei.hosemhin,
    tmp20_dm_cataloghinmei.katanomlt,
    stg_hinmei.hinmei,
    current_timestamp::timestamp_ntz as ldts -- 作成日時
from tmp20_dm_cataloghinmei
inner join stg_hinmei
  on tmp20_dm_cataloghinmei.langkbn = stg_hinmei.langkbn
 and tmp20_dm_cataloghinmei.hinmeicd = stg_hinmei.pnc