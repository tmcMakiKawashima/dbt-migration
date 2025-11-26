{{ config(
      materialized='view'
   ) }}


with stg_katashikihenkanmaster_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_katashikihenkanmaster_pixy') }}
)
select * from stg_katashikihenkanmaster_pixy_view
