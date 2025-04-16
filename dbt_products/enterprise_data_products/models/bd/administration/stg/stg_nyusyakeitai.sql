{{
  config(
    materialized='incremental',
    unique_key = ['nysketcd'],
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

with stg_nyusyakeitai as (
    select
        nysketcd::varchar(1) as nysketcd, -- 入社形態コード
        nysketnam::varchar(10) as nysketnam, -- 入社形態名称
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by nysketcd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20071') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20071')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_nyusyakeitai where aggkey = 1
