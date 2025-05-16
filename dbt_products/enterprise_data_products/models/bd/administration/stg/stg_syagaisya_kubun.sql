{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
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
with stg_syagaisya_kubun as (
    select
        syagaikbn::varchar(1) as syagaikbn, -- 社外者区分コード
        syagaikbnnam::varchar(40) as syagaikbnnam, -- 社外者区分名称
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by syagaikbn
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20077') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20077')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syagaisya_kubun where aggkey = 1
