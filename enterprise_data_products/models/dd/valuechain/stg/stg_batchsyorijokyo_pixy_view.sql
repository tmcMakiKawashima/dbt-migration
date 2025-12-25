{{ config(
      materialized='view'
   ) }}

with stg_batchsyorijokyo_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_batchsyorijokyo_pixy') }}
)
select * from stg_batchsyorijokyo_pixy_view