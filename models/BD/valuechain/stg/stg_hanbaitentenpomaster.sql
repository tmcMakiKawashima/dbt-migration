{{
    config(
        materialized = 'incremental',
        unique_key = ['hanbaitencd','tenpocd'],
        incremental_strategy = 'delete+insert'
    )
}}
with stg_hanbaitentenpomaster as (
    select
        rtrim(M001, ' 　')::varchar(5) as hanbaitencd,
        rtrim(M002, ' 　')::varchar(3) as tenpocd,
        rtrim(M003, ' 　')::varchar(20) as tenponame,
        rtrim(M004, ' 　')::varchar(6) as startym,
        rtrim(M005, ' 　')::varchar(6) as endym,
        ldts,
        rank() over (partition by hanbaitencd, tenpocd order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3211') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_hanbaitentenpomaster where aggkey = 1