{{ config(
      materialized='view'
   ) }}


with stg_tuikouoyakokanren_pixy_view as (
    select 
        * exclude(tantou)
    from {{ ref('stg_tuikouoyakokanren_pixy') }}
)
select * from stg_tuikouoyakokanren_pixy_view
