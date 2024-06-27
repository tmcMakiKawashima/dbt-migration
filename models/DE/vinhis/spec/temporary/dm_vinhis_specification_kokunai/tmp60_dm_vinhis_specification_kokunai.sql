-- データ結合６
with
    tmp50 as (select * from {{ ref('tmp50_dm_vinhis_specification_kokunai') }}),
    hanbai as (
        select
            hanbaino, -- 販売仕様書No
            hkata, -- 販売型式
            shiyoudai, -- 仕様大分類コード
            shiyousai, -- 仕様細目コード
            hsochaku -- 販売装着形態
        from {{ ref('stg_hanbaihikiate') }} -- 販売引当
    )
select
    tmp50.*,
    hanbai.* exclude (hanbaino, hkata, shiyoudai, shiyousai)
from tmp50
left outer join hanbai
  on tmp50.hanbaino = hanbai.hanbaino
 and tmp50.hkata = hanbai.hkata
 and tmp50.shiyodai = hanbai.shiyoudai
 and tmp50.shiyosai = hanbai.shiyousai