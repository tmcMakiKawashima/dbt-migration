{{
    config(
        materialized = 'incremental',
        unique_key = ['codekbnid','key'],
        incremental_strategy = 'delete+insert'
    )
}}

with stg_codekubun as (
    select
        R001::varchar(3) as codekbnid,
        rtrim(R002, ' 　')::varchar(2) as key, --右ブランク
        rtrim(R003, ' 　')::varchar(20) as value, --右ブランク
        R004::varchar(26) as timestamp,
        ldts,
        rank() over (partition by codekbnid, key order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3209') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_codekubun where aggkey = 1
