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