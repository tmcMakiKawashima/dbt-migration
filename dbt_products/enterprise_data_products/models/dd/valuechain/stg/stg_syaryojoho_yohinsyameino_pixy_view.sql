{{ config(
      materialized='view'
   ) }}

with stg_syaryojoho_yohinsyameino_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_syaryojoho_yohinsyameino_pixy') }}
)
select * from stg_syaryojoho_yohinsyameino_pixy_view