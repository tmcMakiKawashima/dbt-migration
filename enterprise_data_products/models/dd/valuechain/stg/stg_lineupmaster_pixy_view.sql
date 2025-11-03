{{ config(
      materialized='view'
   ) }}

with stg_lineupmaster_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_lineupmaster_pixy') }}
)
select * from stg_lineupmaster_pixy_view
