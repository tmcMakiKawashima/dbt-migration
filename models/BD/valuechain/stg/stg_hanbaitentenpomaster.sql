with stg_hanbaitentenpomaster as (
    select
        rtrim(m001, ' 　')::varchar(5) as hanbaitencd, -- 右ブランク
        rtrim(m002, ' 　')::varchar(3) as tenpocd, -- 右ブランク
        m003::varchar(20) as tenponame,
        m004::varchar(6) as startym,
        m005::varchar(6) as endym,
        ldts,
        rank() over (partition by hanbaitencd, tenpocd order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3211') }}
)
select * from stg_hanbaitentenpomaster
where ldts = (select max(ldts) from stg_hanbaitentenpomaster)