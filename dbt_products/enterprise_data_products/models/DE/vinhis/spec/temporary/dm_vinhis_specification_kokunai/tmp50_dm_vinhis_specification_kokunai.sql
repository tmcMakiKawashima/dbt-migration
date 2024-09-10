-- データ結合５
with
    tmp40 as (select * from {{ ref('tmp40_dm_vinhis_specification_kokunai') }}),
    hakko as (
        select * from (
            select 
                syasyu, -- 車種コード
                kirikaeym, -- 代表切替年月
                hanbaino, -- 販売仕様書No
                row_number() over (
                    partition by syasyu 
                    order by kirikaeym desc) as aggkey
            from {{ ref('stg_hakkosyonin') }} -- 発行承認管理
        )
        -- 先頭１レコード抽出条件
        where aggkey= 1
    )
select
    tmp40.*,
    hakko.* exclude (syasyu, kirikaeym, aggkey)
from tmp40
left outer join hakko
  on tmp40.syasyu_cd = hakko.syasyu
 and concat(tmp40.lok_y, tmp40.lok_m) 
     >= hakko.kirikaeym -- ラインオフ計画日に有効な最新の切替年月