{{ config(
      materialized='view'
   )
}}

with stg_hokyuhinbankouseikoute_smshokyu_view as (
  select
    syusbetu::varchar(4) as syusbetu, -- 主管識別
    syutuhin::varchar(10) as syutuhin, -- 出荷品番
    kyokucd::varchar(3) as kyokucd, -- 極コード
    oyahin::varchar(10) as oyahin, -- 親品番
    kohin::varchar(10) as kohin, -- 子品番
    jikt1::varchar(6) as jikt1, -- 自工程1
    jikt2::varchar(6) as jikt2, -- 自工程2
    jikt3::varchar(6) as jikt3, -- 自工程3
    jikt4::varchar(6) as jikt4, -- 自工程4
    jikt5::varchar(6) as jikt5, -- 自工程5
    jikt6::varchar(6) as jikt6, -- 自工程6
    jikt7::varchar(6) as jikt7, -- 自工程7
    jikt8::varchar(6) as jikt8, -- 自工程8
    jikt9::varchar(6) as jikt9, -- 自工程9
    jikt10::varchar(6) as jikt10, -- 自工程10
    jikt11::varchar(6) as jikt11, -- 自工程11
    jikt12::varchar(6) as jikt12, -- 自工程12
    jikt13::varchar(6) as jikt13, -- 自工程13
    jikt14::varchar(6) as jikt14, -- 自工程14
    oyakt::varchar(6) as oyakt, -- 親工程
    sepjunk::varchar(9) as sepjunk, -- 設変登録順(カラ)
    sepjunm::varchar(9) as sepjunm, -- 設変登録順(マデ)
    kosu::varchar(3) as kosu, -- 使用個数
    sentaku::varchar(2) as sentaku, -- 選択符号
    ktkbn::varchar(2) as ktkbn, -- 工程区分
    ktchk::varchar(1) as ktchk, -- 工程チェック
    ktkosu::varchar(2) as ktkosu, -- 工程個数
    tekikara::varchar(8) as tekikara, -- 適用期間_カラ
    tekimade::varchar(8) as tekimade, -- 適用期間_マデ
    torokud::varchar(8) as torokud, -- 登録日
    torokut::varchar(6) as torokut, -- 登録時間
    kosind::varchar(8) as kosind, -- 更新日
    kosint::varchar(6) as kosint, -- 更新時間
    kosinsya::varchar(16) as kosinsya, -- 更新者
    ldts -- B層取込日時
  from {{ ref('stg_hokyuhinbankouseikoute_smshokyu') }}
  where syusbetu = '01TM'
)
select * from stg_hokyuhinbankouseikoute_smshokyu_view