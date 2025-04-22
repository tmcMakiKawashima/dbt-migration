{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','ecikubun','kubun','syasyu ','kumitate','bui ','variation'],
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
  select * from {{ref('raw_stg_syasyu')}}
), kkj as (
  select * from {{ref('stg_eci_kirikaejiki')}}
), thn_bmts as (
  select
    thn.seppenno, -- 設変No.
    thn.kubun, -- 区分
    thn.syasyu, -- 車種コード
    thn.kumitate, -- 組立番号
    thn.bui, -- 部位
    thn.variation, -- バリエーション
    thn.sinhaikbn, -- 新廃区分
    thn.ecikbn, -- 設変書区分
    thn.tousai, -- 搭載車種
    thn.cond, -- Condition
    thn.meisyo, -- 名称
    bmts.torokujun, -- 登録／生認順
    bmts.sijino -- 指示書Ｎｏ．
  from thn
  left join bmts
  on (
      trim(bmts.jigyoutai) = '  '
  and thn.syasyu = bmts.syasyu
  and thn.kumitate = bmts.kumitate
  and thn.bui = bmts.bui
  and thn.seppenno = bmts.seppenno
  and thn.cond in ('ECI(Contents)','LECI(Contents)')
  )
), thn_bmts_syasyu as (
  select
    thn_bmts.seppenno, -- 設変No.
    thn_bmts.kubun, -- 区分
    thn_bmts.syasyu, -- 車種コード
    thn_bmts.kumitate, -- 組立番号
    thn_bmts.bui, -- 部位
    thn_bmts.variation, -- バリエーション
    thn_bmts.sinhaikbn, -- 新廃区分
    thn_bmts.ecikbn, -- 設変書区分
    thn_bmts.tousai, -- 搭載車種
    thn_bmts.cond, -- Condition
    thn_bmts.meisyo, -- 名称
    thn_bmts.torokujun, -- 登録／生認順
    thn_bmts.sijino, -- 指示書Ｎｏ．
    sy.syukan, -- 主管会社
    sy.tantogaisya -- 担当会社区分
  from thn_bmts
  left join sy
  on (
      thn_bmts.syasyu = sy.syasyu
  )
)
select
    thn_bmts_syasyu.seppenno::varchar(10) as seppenno, -- 設変No.
    thn_bmts_syasyu.kubun::varchar(3) as kubun, -- 区分
    thn_bmts_syasyu.syasyu::varchar(4) as syasyu, -- 車種コード
    thn_bmts_syasyu.kumitate::varchar(4) as kumitate, -- 組立番号
    thn_bmts_syasyu.bui::varchar(2) as bui, -- 部位
    thn_bmts_syasyu.variation::varchar(4) as variation, -- バリエーション
    thn_bmts_syasyu.sinhaikbn::varchar(1) as sinhaikbn, -- 新廃区分
    thn_bmts_syasyu.tousai::varchar(4) as tousai, -- 搭載車種
    thn_bmts_syasyu.ecikbn::varchar(10) as ecikbn, -- 設変書区分
    thn_bmts_syasyu.meisyo::varchar(40) as meisyo, -- 名称
    thn_bmts_syasyu.cond::varchar(30) as cond, -- Condition
    coalesce(kkj.kirijikijp, rpad('', 50))::varchar(50) as kirijikijp , -- 切替希望時期(日)
    coalesce(kkj.kirijikien, rpad('', 100))::varchar(100) as kirijikien, -- 切替希望時期(英)
    coalesce(thn_bmts_syasyu.syukan, rpad('', 2))::varchar(2) as syukan, -- 主管会社
    coalesce(thn_bmts_syasyu.tantogaisya, rpad('', 2))::varchar(2) as tantogaisya, -- 担当会社区分
    coalesce(thn_bmts_syasyu.torokujun, rpad('', 9))::varchar(9) as torokujun, -- 登録／生認順
    coalesce(thn_bmts_syasyu.sijino, rpad('', 9))::varchar(9) as sijino, -- 指示書Ｎｏ．
    current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from thn_bmts_syasyu
left join kkj
on(
    thn_bmts_syasyu.seppenno = kkj.seppenno
and thn_bmts_syasyu.kubun = kkj.ecikbn
)
