{{ config(
      materialized='view'
   ) }}

with stg_avnsyohinhinmokumeisyo_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_avnsyohinhinmokumeisyo_pixy') }}
)
select * from stg_avnsyohinhinmokumeisyo_pixy_view