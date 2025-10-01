{{
    config (
        materialized='view'
    )
}}

with
    tmp30_dm_cataloghinmei as (
        select * from {{ ref('tmp30_dm_cataloghinmei') }}
    ),
    stg_hinmei as (
        select
            langkbn, -- 言語区分
            pnc, -- 品名コード
            hinmei -- 品名
        from {{ ref('stg_hinmei') }} -- 品名
    )
select
    tmp30_dm_cataloghinmei.ctlgcd,
    tmp30_dm_cataloghinmei.syakata,
    tmp30_dm_cataloghinmei.syasyu_cd,
    tmp30_dm_cataloghinmei.jissijikik,
    tmp30_dm_cataloghinmei.jissijikim,
    tmp30_dm_cataloghinmei.frmnokata,
    tmp30_dm_cataloghinmei.katano,
    tmp30_dm_cataloghinmei.katatokukg1,
    tmp30_dm_cataloghinmei.katatokukg2,
    tmp30_dm_cataloghinmei.katatokukg3,
    tmp30_dm_cataloghinmei.katatokukg4,
    tmp30_dm_cataloghinmei.katatokukg5,
    tmp30_dm_cataloghinmei.katatokukg6,
    tmp30_dm_cataloghinmei.katatokukg7,
    tmp30_dm_cataloghinmei.syamei,
    tmp30_dm_cataloghinmei.syameizen,
    tmp30_dm_cataloghinmei.syameizenkana,
    tmp30_dm_cataloghinmei.daikata,
    tmp30_dm_cataloghinmei.seisank,
    tmp30_dm_cataloghinmei.seisanm,
    tmp30_dm_cataloghinmei.lexusflg,
    tmp30_dm_cataloghinmei.prts1kbn,
    tmp30_dm_cataloghinmei.tksyuflg,
    tmp30_dm_cataloghinmei.langkbn,
    tmp30_dm_cataloghinmei.hinmeicd,
    tmp30_dm_cataloghinmei.hinban,
    tmp30_dm_cataloghinmei.kosu,
    tmp30_dm_cataloghinmei.siyoptno,
    tmp30_dm_cataloghinmei.epckataptno,
    tmp30_dm_cataloghinmei.kiricdk,
    tmp30_dm_cataloghinmei.kiricdm,
    tmp30_dm_cataloghinmei.trmcdmlt,
    tmp30_dm_cataloghinmei.clrcdmlt,
    tmp30_dm_cataloghinmei.tkstkbn,
    tmp30_dm_cataloghinmei.hktkgaikbn,
    tmp30_dm_cataloghinmei.hosemhin,
    tmp30_dm_cataloghinmei.katanomlt,
    stg_hinmei.hinmei,
from tmp30_dm_cataloghinmei
inner join stg_hinmei
  on tmp30_dm_cataloghinmei.langkbn = stg_hinmei.langkbn
 and tmp30_dm_cataloghinmei.hinmeicd = stg_hinmei.pnc