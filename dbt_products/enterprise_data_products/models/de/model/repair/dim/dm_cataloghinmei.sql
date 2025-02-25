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
    tmp20_dm_cataloghinmei.ctlgcd||tmp20_dm_cataloghinmei.syakata||tmp20_dm_cataloghinmei.syasyu_cd||tmp20_dm_cataloghinmei.jissijikik||tmp20_dm_cataloghinmei.jissijikim||tmp20_dm_cataloghinmei.langkbn||tmp20_dm_cataloghinmei.hinmeicd||tmp20_dm_cataloghinmei.epckataptno||tmp20_dm_cataloghinmei.katano||tmp20_dm_cataloghinmei.hinban||tmp20_dm_cataloghinmei.kosu||tmp20_dm_cataloghinmei.siyoptno||tmp20_dm_cataloghinmei.kiricdk||tmp20_dm_cataloghinmei.kiricdm||tmp20_dm_cataloghinmei.trmcdmlt||tmp20_dm_cataloghinmei.clrcdmlt||tmp20_dm_cataloghinmei.tkstkbn||tmp20_dm_cataloghinmei.hktkgaikbn||tmp20_dm_cataloghinmei.hosemhin as surrogate_key, --サロゲートキー
    tmp20_dm_cataloghinmei.*,
    stg_hinmei.hinmei,
    current_timestamp::timestamp_ntz as ldts -- 作成日時
from tmp20_dm_cataloghinmei
inner join stg_hinmei
  on tmp20_dm_cataloghinmei.langkbn = stg_hinmei.langkbn
 and tmp20_dm_cataloghinmei.hinmeicd = stg_hinmei.pnc