{{ config(
      materialized='view'
   )
}}

with stg_systemmei_aisac_view as (
    select
        * exclude(systorokuuserid, syskosinuserid)
    from {{ ref('stg_systemmei_aisac') }}
)
select * from stg_systemmei_aisac_view