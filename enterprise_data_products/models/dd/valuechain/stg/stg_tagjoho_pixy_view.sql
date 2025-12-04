{{ config(
      materialized='view'
   ) }}

with stg_tagjoho_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_tagjoho_pixy') }}
)
select * from stg_tagjoho_pixy_view
