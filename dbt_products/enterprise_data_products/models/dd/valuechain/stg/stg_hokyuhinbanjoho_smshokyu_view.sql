{{ config(
      materialized='view'
   )
}}

with stg_hokyuhinbanjoho_smshokyu_view as (
  select
    syusbetu::varchar(4) as syusbetu, -- 主管識別
    hinban::varchar(10) as hinban, -- 品番
    ruibetu::varchar(2) as ruibetu, -- 類別
    kerekijun::varchar(5) as kerekijun, -- 経歴順
    sepnok::varchar(10) as sepnok, -- 設変no（カラ）
    sepnom::varchar(10) as sepnom, -- 設変no（マデ）
    hokyukbn::varchar(2) as hokyukbn, -- 補給区分
    genkyu::varchar(1) as genkyu, -- 現旧区分
    tekikara::varchar(8) as tekikara, -- 適用期間_カラ
    tekimade::varchar(8) as tekimade, -- 適用期間_マデ
    mukoflg::varchar(1) as mukoflg, -- 無効flg
    torokud::varchar(8) as torokud, -- 登録日
    torokut::varchar(6) as torokut, -- 登録時間
    kosind::varchar(8) as kosind, -- 更新日
    kosint::varchar(6) as kosint, -- 更新時間
    kosinsya::varchar(16) as kosinsya, -- 更新者
    ldts -- B層取込日時
  from {{ ref('stg_hokyuhinbanjoho_smshokyu') }}
)
select * from stg_hokyuhinbanjoho_smshokyu_view
where syusbetu = '01TM'