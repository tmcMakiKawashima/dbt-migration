{{ config(
      materialized='view'
   ) }}


with stg_yohinsyameino_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_yohinsyameino_pixy') }}
)
select * from stg_yohinsyameino_pixy_view
