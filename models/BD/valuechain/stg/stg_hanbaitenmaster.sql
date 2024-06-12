{{
    config(
        materialized = 'incremental',
        unique_key = 'hanbaitencd',
        incremental_strategy = 'delete+insert'
    )
}}
with stg_hanbaitenmaster as (
    select
        rtrim(R001, ' 　')::varchar(5) as hanbaitencd,
        rtrim(R002, ' 　')::varchar(5) as hanbaitenname,
        ldts,
        rank() over (partition by hanbaitencd order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3210') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_hanbaitenmaster where aggkey = 1
