{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
with dm_kousei_blktenkai as (
select
  syasyu, -- 車種コード
  siyoubui, -- 使用部位
  kumitate, -- 組立番号
  bui, -- 部位
  motosiyoubui, -- 元使用部位
  vari, -- バリエーション
  oyahin, -- 親品番
  lv, -- レベル
  kouseijyun, -- 構成順
  gc, -- GC
  kohin, -- 品番／BLKコード
  kohinmei, -- 品名／BLKコード名称
  kosu, -- 使用個数
  sentaku, -- 選択符号
  tyohuku, -- 重複記載
  torokujunk::varchar(9) as torokujunk, -- 登録／生認順カラ 参照元の桁数定義に不備があるため
  torokujunm::varchar(9) as torokujunm, -- 登録／生認順マデ 参照元の桁数定義に不備があるため
  seppennok, -- 設変No.カラ
  seppennom, -- 設変No.マデ
  torokutimek, -- LOAD TIMEカラ
  torokutimem, -- LOAD TIMEマデ
  ldts -- B層処理日時
from {{source('parts_list_db_sms', 'raw_dm_kousei_blktenkai')}}
)
select
  ks.*,
  tmp.* exclude(syasyu)
from {{source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai')}} as tmp
left join {{ref('tmp_junkanri_jyufukublktenkai_eph')}} as zt
on (
    tmp.syasyu = zt.syasyu
and tmp.maxmttime > zt.maxmttime
)
inner join dm_kousei_blktenkai as ks
on (
    tmp.syasyu = ks.syasyu
)
where tmp.target = 'KOUSEI'