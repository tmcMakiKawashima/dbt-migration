{{ config(
      materialized='view'
   ) }}

with stg_categorymaster_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_categorymaster_pixy') }}
)
select * from stg_categorymaster_pixy_view
