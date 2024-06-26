with stg_hanbaitenmaster as (
    select
        rtrim(r001, ' 　')::varchar(5) as hanbaitencd, --右ブランク
        r002::varchar(5) as hanbaitenname,
        ldts
    from {{ ref('substr_ktrla025zz0kil3210') }}
)
select * from stg_hanbaitenmaster
where ldts = (select max(ldts) from stg_hanbaitenmaster)
