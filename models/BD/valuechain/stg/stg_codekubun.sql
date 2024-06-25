{{
    config(
        materialized = 'incremental',
        unique_key = ['codekbnid','key'],
        incremental_strategy = 'delete+insert'
    )
}}

with stg_codekubun as (
    select
        r001::varchar(3) as codekbnid,
        rtrim(r002, ' 　')::varchar(2) as key, --右ブランク
        rtrim(r003, ' 　')::varchar(20) as value, --右ブランク
        r004::varchar(26) as timestamp,
        ldts,
        rank() over (partition by codekbnid, key order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3209') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_codekubun where aggkey = 1
