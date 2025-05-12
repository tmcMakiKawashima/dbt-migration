{{
  config(
    materialized='incremental',
    unique_key = ['bnycd'],
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
with stg_bunya as (
    select
        bnycd::varchar(3) as bnycd, -- 分野コード
        bnynam::varchar(24) as bnynam, -- 分野名称
        rskbnynam::varchar(8) as rskbnynam, -- 略式分野名称
        bnytktbucd::varchar(2) as bnytktbucd, -- 分野統括部コード
        ldts::timestamp as ldts, -- B層取込日時
        row_number() over(partition by bnycd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20076') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20076')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_bunya where aggkey = 1
