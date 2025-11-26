{{ config(
      materialized='view'
   ) }}

with stg_battingjoho_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_battingjoho_pixy') }}
)
select * from stg_battingjoho_pixy_view
