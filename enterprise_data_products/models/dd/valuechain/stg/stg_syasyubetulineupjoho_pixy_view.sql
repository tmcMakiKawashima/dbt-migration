{{ config(
      materialized='view'
   ) }}

with stg_syasyubetulineupjoho_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_syasyubetulineupjoho_pixy') }}
)
select * from stg_syasyubetulineupjoho_pixy_view