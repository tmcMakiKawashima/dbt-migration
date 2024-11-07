{{
  config(
    materialized='incremental',
    unique_key = ['noshucho','ddstart'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_businesstrip as (
    select
        noshucho::varchar(11) as noshucho,
        cdworker::varchar(10) as cdworker,
        ddstart::varchar(8) as ddstart,
        ddend::varchar(8) as ddend,
        tmstart::varchar(4) as tmstart,
        tmend::varchar(4) as tmend,
        nmcountry::varchar(30) as nmcountry,
        nmkyoten::varchar(28) as nmkyoten,
        nmshucho::varchar(28) as nmshucho,
        ldts,
        row_number() over(partition by noshucho,ddstart
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20063')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_businesstrip where aggkey = 1
