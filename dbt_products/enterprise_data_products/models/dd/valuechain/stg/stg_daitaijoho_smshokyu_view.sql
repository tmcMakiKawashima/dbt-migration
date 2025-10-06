{{ config(
      materialized='view'
   )
}}

with stg_daitaijoho_smshokyu_view as (
  select
    syusbetu::varchar(4) as syusbetu, -- 主管識別
    hinban::varchar(10) as hinban, -- 品番
    ruibetu::varchar(2) as ruibetu, -- 類別
    daihin::varchar(10) as daihin, -- 代替品番
    daihinrui::varchar(2) as daihinrui, -- 代替品番類別
    kerekijun::varchar(5) as kerekijun, -- 経歴順
    sepnok::varchar(10) as sepnok, -- 設変no（カラ）
    sepnom::varchar(10) as sepnom, -- 設変no（マデ）
    daikbn::varchar(2) as daikbn, -- 代替区分
    daikosu::varchar(2) as daikosu, -- 代替個数
    sentakukbn::varchar(2) as sentakukbn, -- 選択区分
    setm::varchar(2) as setm, -- セットマーク
    daicmt::varchar(30) as daicmt, -- 代替コメント
    tekikara::varchar(8) as tekikara, -- 適用期間_カラ
    tekimade::varchar(8) as tekimade, -- 適用期間_マデ
    mukoflg::varchar(1) as mukoflg, -- 無効flg
    mainhin30::varchar(12) as mainhin30, -- メイン品番（30の）
    torokud::varchar(8) as torokud, -- 登録日
    torokut::varchar(6) as torokut, -- 登録時間
    kosind::varchar(8) as kosind, -- 更新日
    kosint::varchar(6) as kosint, -- 更新時間
    kosinsya::varchar(16) as kosinsya, -- 更新者
    ldts -- B層取込日時
  from {{ ref('stg_daitaijoho_smshokyu') }}
  where syusbetu = '01TM'
)
select * from stg_daitaijoho_smshokyu_view