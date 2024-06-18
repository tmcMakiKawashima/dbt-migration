{{
    config(
        materialized = 'incremental',
        unique_key = 'hinban',
        incremental_strategy = 'delete+insert'
    )
}}
with stg_hinbanmeisyomaster as (
    select
        rtrim(PARTS_CD, ' 　')::varchar(15) as hinban, -- 右ブランク
        rtrim(DUO_PARTS_CD, ' 　')::varchar(15) as DUO_PARTS_CD, -- 右ブランク
        0::number(7) as sell_price, -- マスク
        0::number(7) as cost, -- マスク
        rtrim(DAITAI_PARTS_CD, ' 　')::varchar(15) as daitaihinban, -- 右ブランク
        DAITAI_CD::varchar(1) as daitaihinbancd,
        MAKER_KBN::varchar(1) as MAKER_KBN,
        rtrim(PARTS_NAME, ' 　')::varchar(60) as hinemei, -- 右ブランク
        rtrim(PARTS_NAME_CD, ' 　')::varchar(6) as hinmeicd, -- 右ブランク
        ldts,
        rank() over (partition by hinban order by ldts desc) aggkey
    from {{ source('customerservice_db_public', 'stg_hinbanmeisyomaster') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_hinbanmeisyomaster where aggkey = 1