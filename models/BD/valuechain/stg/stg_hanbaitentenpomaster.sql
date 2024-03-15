with stg_hanbaitentenpomaster as (
    select
        rtrim(hanbaitencd, ' 　')::varchar(5) as hanbaitencd,
        rtrim(tenpocd, ' 　')::varchar(3) as tenpocd,
        rtrim(tenponame, ' 　')::varchar(20) as tenponame,
        rtrim(startym, ' 　')::varchar(6) as startym,
        rtrim(endym, ' 　')::varchar(6) as endym,
        ldts,
        rank() over (partition by hanbaitencd, tenpocd order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3211') }}
)
select * from stg_hanbaitentenpomaster
where aggkey = 1
