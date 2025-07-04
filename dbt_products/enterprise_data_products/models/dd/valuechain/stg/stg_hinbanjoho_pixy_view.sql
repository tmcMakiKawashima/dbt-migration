{{ config(
      materialized='view'
   ) }}

with stg_hinbanjoho_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_hinbanjoho_pixy') }}
)
select * from stg_hinbanjoho_pixy_view