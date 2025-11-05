{{
    config(
        materialized='table'
    )
}}
with
  kousei_all as (
    select * from {{ref('tmp_legacy_kousei00_blktenkai_4_kousei_all')}}
  )
--使用部位単位に行idを付与
select *,
       cast(lpad(row_number() over (
         partition by syasyu,
                      siyoubui
         order by concat(gc_fill,kohin,gc)),4,'0') as varchar
       ) as id
from kousei_all