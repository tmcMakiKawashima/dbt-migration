{{ 
  config(
    materialized='incremental',
    unique_key = ['employee_cd','htrymd','syozoku_cd','ykwrcd'],
    pre_hook=[
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ]
  )
}}
-- 洗い替え処理で常に最新断面のみとするためpre_hookで全件削除する処理を記載
with stg_yakuwari_history as (
    select
        jcd::varchar(7) as employee_cd, -- 従業員コード
        htrymd::varchar(8) as htrymd, -- 発令年月日
        szcd::varchar(5) as syozoku_cd, -- 所属コード
        ykwrcd::varchar(3) as ykwrcd, -- 職位手当区分コード
        rskykwrnam::varchar(16) as rskykwrnam, -- 略式役割名称
        sykicd::varchar(3) as sykicd, -- 職位コード
        rsksykinam::varchar(12) as rsksykinam, -- 略式職位名称
        hriszkmuf::varchar(1) as hriszkmuf, -- 本来所属兼務フラグ
        ykwrenymd::varchar(8) as ykwrenymd, -- 役割終了年月日
        updflg::varchar(1) as updflg, -- 更新フラグ
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by employee_cd, htrymd, syozoku_cd, ykwrcd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20080') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20080')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_yakuwari_history where aggkey = 1
