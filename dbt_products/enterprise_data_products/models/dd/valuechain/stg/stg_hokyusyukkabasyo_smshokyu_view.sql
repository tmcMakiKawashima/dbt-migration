{{ config(
      materialized='view'
   )
}}

with stg_hokyusyukkabasyo_smshokyu_view as (
  select
    syusbetu::varchar(4) as syusbetu, -- 主管識別
    hinban::varchar(10) as hinban, -- 品番
    ruibetu::varchar(2) as ruibetu, -- 類別
    kyokucd::varchar(3) as kyokucd, -- 極コード
    kerekijun::varchar(5) as kerekijun, -- 経歴順
    sepnok::varchar(10) as sepnok, -- 設変no（カラ）
    sepnom::varchar(10) as sepnom, -- 設変no（マデ）
    hokanjoho::varchar(8) as hokanjoho, -- 補給関連情報
    ktsyasyu::varchar(4) as ktsyasyu, -- 工程車種コード
    ktsiyoubui::varchar(10) as ktsiyoubui, -- 工程使用部位
    ktoyahin::varchar(10) as ktoyahin, -- 工程親品番
    ktgc::varchar(2) as ktgc, -- 工程グループコード
    jigyoutai::varchar(2) as jigyoutai, -- 生産事業体
    tokuyukote::varchar(1) as tokuyukote, -- 工程種類
    hosyukote1::varchar(6) as hosyukote1, -- 補給出荷工程1
    hosyukote2::varchar(6) as hosyukote2, -- 補給出荷工程2
    hosyukote3::varchar(6) as hosyukote3, -- 補給出荷工程3
    hosyukote4::varchar(6) as hosyukote4, -- 補給出荷工程4
    hosyukote5::varchar(6) as hosyukote5, -- 補給出荷工程5
    hosyukote6::varchar(6) as hosyukote6, -- 補給出荷工程6
    hosyukote7::varchar(6) as hosyukote7, -- 補給出荷工程7
    hosyukote8::varchar(6) as hosyukote8, -- 補給出荷工程8
    hosyukote9::varchar(6) as hosyukote9, -- 補給出荷工程9
    hosyukote10::varchar(6) as hosyukote10, -- 補給出荷工程10
    hosyukote11::varchar(6) as hosyukote11, -- 補給出荷工程11
    hosyukote12::varchar(6) as hosyukote12, -- 補給出荷工程12
    hosyukote13::varchar(6) as hosyukote13, -- 補給出荷工程13
    hosyukote14::varchar(6) as hosyukote14, -- 補給出荷工程14
    hosyubas::varchar(6) as hosyubas, -- 補給出荷場所
    tosobas::varchar(6) as tosobas, -- 塗装場所
    boubas::varchar(6) as boubas, -- 防錆場所
    tekikara::varchar(8) as tekikara, -- 適用期間_カラ
    tekimade::varchar(8) as tekimade, -- 適用期間_マデ
    mukoflg::varchar(1) as mukoflg, -- 無効flg
    genkyu::varchar(1) as genkyu, -- 現旧区分
    hoseikbn::varchar(1) as hoseikbn, -- 補給生産区分
    torokud::varchar(8) as torokud, -- 登録日
    torokut::varchar(6) as torokut, -- 登録時間
    kosind::varchar(8) as kosind, -- 更新日
    kosint::varchar(6) as kosint, -- 更新時間
    kosinsya::varchar(16) as kosinsya, -- 更新者
    ldts -- B層取込日時
  from {{ ref('stg_hokyusyukkabasyo_smshokyu') }}
)
select * from stg_hokyusyukkabasyo_smshokyu_view
where syusbetu = '01TM'