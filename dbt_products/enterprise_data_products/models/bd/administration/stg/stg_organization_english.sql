{{
  config(
    materialized='incremental',
    unique_key = ['bucd','stkcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_organization_english as (
    select
        bucd::varchar(2) as bucd,
        stkcd::varchar(3) as stkcd,
        sskbunam::varchar(30) as sskbunam,
        sskstknam::varchar(30) as sskstknam,
        ebnsms1::varchar(200) as ebnsms1,
        ebnsms2::varchar(200) as ebnsms2,
        ldts,
        row_number() over(partition by bucd,stkcd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_organization_english where aggkey = 1
