{{ 
  config(
    materialized='incremental',
    unique_key = ['employee_cd'],
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

with stg_exmail as (
    select
        jcd::varchar(7) as employee_cd, -- 従業員コード
        ex_mail::varchar(256) as ex_mail, -- メールアドレス
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by employee_cd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20078') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20078')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_exmail where aggkey = 1
