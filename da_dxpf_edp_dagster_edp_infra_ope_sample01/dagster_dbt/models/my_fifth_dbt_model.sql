{{ config(
    group = 'asset_sample06'
    )
}}

select
    *
from {{ source("edp_db", "asset06_03") }}