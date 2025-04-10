{{ 
  config(
    materialized='incremental',
    unique_key = ['syagaikbn'],
    incremental_strategy = 'append',
    pre_hook=[
      "{{ dbt_snow_mask.create_masking_policy('models')}}",
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ]
  )
}}

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
