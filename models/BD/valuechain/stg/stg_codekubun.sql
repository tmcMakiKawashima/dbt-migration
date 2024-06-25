with stg_codekubun as (
    select
        r001::varchar(3) as codekbnid,
        rtrim(r002, ' 　')::varchar(2) as key, --右ブランク
        rtrim(r003, ' 　')::varchar(20) as value, --右ブランク
        r004::varchar(26) as timestamp,
        ldts,
    from {{ ref('substr_ktrla025zz0kil3209') }}
)
select * from stg_codekubun
where ldts = (select max(ldts) from stg_codekubun)