{{ config(
    group = 'pipeline01'
    )
}}

select 
    * 
from {{ source("fivetran_db", "dagster_poc") }}