-- データ結合６
with
    tmp55 as (select * from {{ ref('tmp55_dm_vinhis_specification_kokunai') }}),
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
    tmp55.*,
    hanbai.* exclude (hanbaino, hkata, shiyoudai, shiyousai)
from tmp55
left outer join hanbai
  on tmp55.hanbaino = hanbai.hanbaino
 and tmp55.hkata = hanbai.hkata
 and tmp55.shiyodai = hanbai.shiyoudai
 and tmp55.shiyosai = hanbai.shiyousai