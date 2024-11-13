{{
  config(
    materialized='incremental',
    unique_key = ['employee_cd','namhnkyukymd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_name_history as (
    select
        jcd::varchar(7) as employee_cd,
        kyseisyumf::varchar(1) as kyseisyumf,
        hnkgkjnam::varchar(20) as hnkgkjnam,
        hnkgknnam::varchar(20) as hnkgknnam,
        hnkgrmnam::varchar(50) as hnkgrmnam,
        namhnkyukymd::varchar(8) as namhnkyukymd,
        namhnksnymd::varchar(8) as namhnksnymd,
        kyseinamkanji::varchar(20) as kyseinamkanji,
        kyseinamkana::varchar(20) as kyseinamkana,
        kyseinamrmj::varchar(50) as kyseinamrmj,
        namhnkriycd::varchar(1) as namhnkriycd,
        namhenriysnt::varchar(40) as namhenriysnt,
        namdtasosnflg::varchar(1) as namdtasosnflg,
        ldts,
        row_number() over(partition by employee_cd,namhnkyukymd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20069')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20069')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_name_history where aggkey = 1
