with
    tmp20_dm_figbunkaiinfo as (
        select * from {{ ref('tmp20_dm_figbunkaiinfo') }}
    ),
    stg_illustcomment as (
        select
            ilstcmtno, -- イラストコメントNO
            ilstcmt -- イラストコメント
        from {{ ref('stg_illustcomment') }} -- イラストコメント
    )
select
    tmp20_dm_figbunkaiinfo.*,
    stg_illustcomment.ilstcmt
from tmp20_dm_figbunkaiinfo
inner join stg_illustcomment
  on tmp20_dm_figbunkaiinfo.ilstcmtno = stg_illustcomment.ilstcmtno