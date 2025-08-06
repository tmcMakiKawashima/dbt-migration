select
  syasyu,  -- 車種コード
  kumitate,  -- 組立番号
  bui,  -- 部位
  vari,  -- バリエーション
  max(seppen_no_kara) as seppen_no_kara,  -- 設変Noカラ
  haisya_kt,  -- 配車型式
  spec200,  -- SPEC200桁組合せ
  max(daisai200) as daisai200,  -- SPEC対応4桁仕様
  sk_y,  -- 終検日年
  sk_m,  -- 終検日月
  count(*)::number(13,0) as daisu  -- 台数
from {{ref('tmp10_dm_variation_seisan_daisu')}}
group by 
  syasyu,
  kumitate,
  bui,
  vari,
  haisya_kt,
  spec200,
  sk_y,
  sk_m