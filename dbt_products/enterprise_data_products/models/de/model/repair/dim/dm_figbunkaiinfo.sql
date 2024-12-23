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