{{ config(
    group = 'asset_sample03'
    )
}}

select
    *
from {{ source("edp_db", "asset03_01") }}