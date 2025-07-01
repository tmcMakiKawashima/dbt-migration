{{ config(
      materialized='view'
   ) }}

with stg_tuikousotyakujokenjoho_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_tuikousotyakujokenjoho_pixy') }}
)
select * from stg_tuikousotyakujokenjoho_pixy_view