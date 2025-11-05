{{ config(
      materialized='view'
   ) }}


with stg_yohinmaster_pixy_view as (
    select 
        * exclude(dn,torihi,syasin)
    from {{ ref('stg_yohinmaster_pixy') }}
)
select * from stg_yohinmaster_pixy_view
