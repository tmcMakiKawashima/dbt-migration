{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
              delete from {{this}} a
              using {{ source('parts_list_db_sms', 'raw_tmp_kousei03_blktenkai') }} b
              where a.syasyu = b.syasyu 
            {% endif %}
        "
    )
}}
--最後に実施した最大値の順('999999999'以外)を保持している為、pre_hookで削除を行う。

with 
  tmp_kousei03_main as (
    select
      syasyu,
      'KOUSEI' as target,
      max(iff(torokujunm='999999999', torokujunk, torokujunm)) as torokujun,
      to_char(current_timestamp, 'yyyymmddhhmissff2') as mttime 
    from {{ source('parts_list_db_sms', 'raw_tmp_kousei03_blktenkai') }}
    group by
    syasyu
  ),
  tmp_kousei03_sub1 as (
    select
      syasyu_cd,
      torokujun,
      seppenno
     from {{ source('engineering_db_public', 'raw_stg_mokujihonshijun') }}
     where trim(jigyoutai) = ''
     group by
     syasyu_cd,
     torokujun,
     seppenno
  ),
  tmp_kousei03_sub2 as (
    select
      syasyu,
      max(mttime) as maxmttime
    from {{ source('engineering_db_public', 'raw_stg_kousei') }}
    where trim(jigyoutai) = ''
    group by
    syasyu
  ),
  tmp_kousei03_sub3 as (
    select
      syasyu,
      max(mttime) as maxmttime
    from {{ source('engineering_db_public', 'raw_stg_kouseicom') }}
    where trim(jigyoutai) = '' 
    and comkbn='11'
    group by
    syasyu
  ) 

select
  tmp_kousei03_main.syasyu,
  tmp_kousei03_main.target,
  tmp_kousei03_main.torokujun,
  tmp_kousei03_sub1.seppenno,
  iff(tmp_kousei03_sub2.maxmttime < tmp_kousei03_sub3.maxmttime, tmp_kousei03_sub3.maxmttime, tmp_kousei03_sub2.maxmttime) as maxmttime,
  tmp_kousei03_main.mttime
from tmp_kousei03_main
left join tmp_kousei03_sub1
  on tmp_kousei03_main.syasyu = tmp_kousei03_sub1.syasyu_cd
  and tmp_kousei03_main.torokujun = tmp_kousei03_sub1.torokujun
left join tmp_kousei03_sub2
  on tmp_kousei03_main.syasyu = tmp_kousei03_sub2.syasyu
left join tmp_kousei03_sub3
  on tmp_kousei03_main.syasyu = tmp_kousei03_sub3.syasyu