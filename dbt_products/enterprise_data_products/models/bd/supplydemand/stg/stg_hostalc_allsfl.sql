{{
  config(
    materialized = 'incremental',
    unique_key = ['psc', 'plantcode', 'lodate', 'idno', 'msgno'],
    incremental_strategy = 'merge'
  )
}}

with stg_hostalc_allsfl as (
  select
    rtrim(psc, ' 　')::varchar(2) as psc, -- PSC
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(idno, ' 　')::varchar(10) as idno, -- アイデントNO
    rtrim(msgno, ' 　')::varchar(4) as msgno, -- MSGNO
    labelinfo::varchar(50) as labelinfo, -- ラベル情報
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts, -- B層取込日時
    row_number() over (partition by psc, plantcode, lodate, idno, msgno order by ldts desc, line_number desc) aggkey
  from {{ ref('substr_hostalc_all_cka01t0020') }}

  {% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_hostalc_allsfl where aggkey = 1