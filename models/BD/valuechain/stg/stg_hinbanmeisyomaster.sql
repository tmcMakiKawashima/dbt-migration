with stg_hinbanmeisyomaster as (
    select
        rtrim(parts_cd, ' 　')::varchar(15) as hinban, -- 右ブランク
        rtrim(duo_parts_cd, ' 　')::varchar(15) as duo_parts_cd, -- 右ブランク
        0::number(7) as sell_price, -- マスク
        0::number(7) as cost, -- マスク
        rtrim(daitai_parts_cd, ' 　')::varchar(15) as daitaihinban, -- 右ブランク
        daitai_cd::varchar(1) as daitaihinbancd,
        maker_kbn::varchar(1) as maker_kbn,
        rtrim(parts_name, ' 　')::varchar(60) as hinmei, -- 右ブランク
        rtrim(parts_name_cd, ' 　')::varchar(6) as hinmeicd, -- 右ブランク
        ldts
    from {{ source('customerservice_db_public', 'stg_hinbanmeisyomaster') }}
)
select * from stg_hinbanmeisyomaster
where ldts = (select max(ldts) from stg_hinbanmeisyomaster)