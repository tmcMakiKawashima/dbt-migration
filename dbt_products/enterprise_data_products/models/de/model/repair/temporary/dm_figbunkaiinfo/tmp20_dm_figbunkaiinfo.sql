with
    tmp10_dm_figbunkaiinfo as (
        select * from {{ ref('tmp10_dm_figbunkaiinfo') }}
    ),
    stg_bunkaizuimagekanri as (
        select
            hansno, -- 版下NO
            bnkimgflmei -- 分解図イメージファイル名
        from {{ ref('stg_bunkaizuimagekanri') }} -- 分解図イメージ管理
    )
select
    tmp10_dm_figbunkaiinfo.*,
    stg_bunkaizuimagekanri.bnkimgflmei
from tmp10_dm_figbunkaiinfo
inner join stg_bunkaizuimagekanri
  on tmp10_dm_figbunkaiinfo.hansno = stg_bunkaizuimagekanri.hansno