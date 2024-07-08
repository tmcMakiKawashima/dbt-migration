{{ config(
    group = 'asset_sample08'
    )
}}

select
    *
from {{ source("edp_db", "asset08_01") }}