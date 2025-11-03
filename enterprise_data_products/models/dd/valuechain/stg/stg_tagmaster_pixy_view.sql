{{ config(
      materialized='view'
   ) }}

with stg_tagmaster_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_tagmaster_pixy') }}
)
select * from stg_tagmaster_pixy_view
