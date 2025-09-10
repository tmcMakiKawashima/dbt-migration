with zk as (
  select * from {{ref('tmp04_dm_kousei_jyufukublktenkai')}}
) ks as (
  select * from {{source('parts_list_db', 'raw_dm_kousei_blktenkai')}}
) 
select
  zt.syasyu, -- 車種コード
  ks.siyoubui, -- 使用部位
  ks.kumitate, -- 組立番号
  ks.bui, -- 部位
  ks.motosiyoubui, -- 元使用部位
  zt.aite_siyoubui as shusiyoubui, -- 重複相手先使用部位
  ks.vari, -- バリエーション
  zt.oyahin, -- 親品番
  zt.lv, -- レベル
  ks.kouseijyun, -- 構成順
  ks.gc, -- GC
  zt.kohin, -- 品番／BLKコード
  ks.kohinmei, -- 品名／BLKコード名称
  ks.kosu, -- 使用個数
  ks.sentaku, -- 選択符号
  ks.tyohuku, -- 重複記載
  1 as tyohuku_flg, -- 重複FLG
  ks.torokujunk, -- 登録／生認順カラ
  ks.torokujunm, -- 登録／生認順マデ
  ks.seppennok, -- 設変No.カラ
  ks.seppennom, -- 設変No.マデ
  ks.torokutimek, -- LOAD TIMEカラ
  ks.torokutimem, -- LOAD TIMEマデ
  zt.target, -- ターゲット
  zt.torokujun, -- 登録／生認順
  zt.seppenno, -- 設変No.
  zt.maxmttime, -- MAXMTTIME
  zt.mttime, -- MTTIME
from zk
left join ks
on (
    zk.syasyu = ks.syasyu
and zk.aite_siyoubui = ks.siyoubui
and zk.oyahin = ks.oyahin
and zk.jyufku_kohin = ks.jyufku_kohin   
)