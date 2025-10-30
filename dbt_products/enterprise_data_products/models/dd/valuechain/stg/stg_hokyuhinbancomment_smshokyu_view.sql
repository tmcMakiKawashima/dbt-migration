{{ config(
      materialized='view'
   )
}}

with stg_hokyuhinbancomment_smshokyu_view as (
  select
    syusbetu::varchar(4) as syusbetu, -- 主管識別
    hinban::varchar(10) as hinban, -- 品番
    ruibetu::varchar(2) as ruibetu, -- 類別
    comkbn::varchar(2) as comkbn, -- コメント区分
    hinbancmt::varchar(40) as hinbancmt, -- 品番コメント
    torokud::varchar(8) as torokud, -- 登録日
    torokut::varchar(6) as torokut, -- 登録時間
    kosind::varchar(8) as kosind, -- 更新日
    kosint::varchar(6) as kosint, -- 更新時間
    kosinsya::varchar(16) as kosinsya, -- 更新者
    ldts -- B層取込日時
  from {{ ref('stg_hokyuhinbancomment_smshokyu') }}
  where syusbetu = '01TM'
)
select * from stg_hokyuhinbancomment_smshokyu_view