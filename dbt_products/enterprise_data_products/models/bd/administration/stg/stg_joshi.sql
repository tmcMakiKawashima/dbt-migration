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
with stg_joshi as (
    select
        szcd::varchar(5) as syozoku_cd, -- 所属コード
        synrnk8::varchar(7) as synrnk8, -- 承認ランク８
        synrnk6::varchar(7) as synrnk6, -- 承認ランク６
        synrnk4::varchar(7) as synrnk4, -- 承認ランク４
        synrnk2::varchar(7) as synrnk2, -- 承認ランク２
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by syozoku_cd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20073') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20073')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_joshi where aggkey = 1
