{{ config(snowflake_warehouse='DBT_WH') }}

{# ATOP受注マスタ #}
with stg_o_cvs11jyuchuu as (
    select * from {{ source('valuechain_db_public', 'raw_o_cvs11jyuchuu') }}
)

select * from stg_o_cvs11jyuchuu
