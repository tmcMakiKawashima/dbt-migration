{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
select
  zt.syasyu, -- 車種コード
  ks.siyoubui, -- 使用部位
  ks.kumitate, -- 組立番号
  ks.bui, -- 部位
  ks.motosiyoubui, -- 元使用部位
  zt.shusiyoubui, -- 主側使用部位
  ks.vari, -- バリエーション
  zt.oyahin, -- 親品番
  zt.lv, -- レベル
  zt.kouseijyun, -- 構成順
  ks.gc, -- GC
  zt.kohin, -- 品番／BLKコード
  ks.kohinmei, -- 品名／BLKコード名称
  ks.kosu, -- 使用個数
  ks.sentaku, -- 選択符号
  zt.tyohuku, -- 重複記載
  '1' as tyohuku_flg, -- 重複FLG
  ks.torokujunk::varchar(9) as torokujunk, -- 登録／生認順カラ 参照元桁数定義に不備があるため
  ks.torokujunm::varchar(9) as torokujunm, -- 登録／生認順マデ 参照元桁数定義に不備があるため
  ks.seppennok, -- 設変No.カラ
  ks.seppennom, -- 設変No.マデ
  ks.torokutimek, -- LOAD TIMEカラ
  ks.torokutimem, -- LOAD TIMEマデ
  zt.target, -- ターゲット
  zt.torokujun, -- 登録／生認順
  zt.seppenno, -- 設変No.
  zt.maxmttime, -- MAXMTTIME
  zt.mttime -- MTTIME
from {{ref('tmp04_dm_kousei_jyufukublktenkai')}} as zt
left join {{source('parts_list_db_sms', 'raw_dm_kousei_blktenkai')}} as ks
on (
    zt.syasyu = ks.syasyu
and zt.shusiyoubui = ks.siyoubui
and zt.oyahin = ks.oyahin
and zt.kohin = ks.kohin
)