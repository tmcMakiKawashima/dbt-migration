{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','ecikubun','kubun','syasyu','kumitate','bui','variation','tousai'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
-- 洗い替えであるため、pre_hookで全件削除を行う。

with thn as (
  select * from {{ref('tmp20_dm_tekiyohani_all')}}
), bmts as (
  select * from {{source('engineering_db_public','raw_tmp_m_cyp02mokujibuijun')}}
), sy as (
  -- AISACの処理で作成されたデータをそのまま使用するためジョブで実行除外
  select * from {{ref('stg_syasyu')}} 
), kkj as (
  select * from {{ref('stg_eci_kirikaejiki')}}
)
select
    thn.*,
    coalesce(kkj.kirijikijp, rpad('', 50))::varchar(50) as kirijikijp , -- 切替希望時期(日)
    coalesce(kkj.kirijikien, rpad('', 100))::varchar(100) as kirijikien, -- 切替希望時期(英)
    coalesce(sy.syukan, rpad('', 2))::varchar(2) as syukan, -- 主管会社
    coalesce(sy.tantogaisya, rpad('', 2))::varchar(2) as tantogaisya, -- 担当会社区分
    coalesce(bmts.torokujun, rpad('', 9))::varchar(9) as torokujun, -- 登録／生認順
    coalesce(bmts.sijino, rpad('', 9))::varchar(9) as sijino, -- 指示書Ｎｏ．
    current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from thn
left join bmts
on (
    trim(bmts.jigyoutai) = ''
and thn.syasyu = bmts.syasyu
and thn.kumitate = bmts.kumitate
and thn.bui = bmts.bui
and thn.seppenno = bmts.seppenno
and thn.ecikubun in ('ECI(Contents)','LECI(Contents)')
)
left join sy
on (
    thn.syasyu = sy.syasyu
)
left join kkj
on(
    thn.seppenno = kkj.seppenno
and thn.kubun = kkj.ecikbn
)
