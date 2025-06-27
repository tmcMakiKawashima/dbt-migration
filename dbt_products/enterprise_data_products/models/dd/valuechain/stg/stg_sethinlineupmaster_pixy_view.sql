{{ config(
      materialized='view'
   ) }}

with stg_sethinlineupmaster_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_sethinlineupmaster_pixy') }}
)
select * from stg_sethinlineupmaster_pixy_view
