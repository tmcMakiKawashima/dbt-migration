with stg_hanbaitenmaster as (
    select
        rtrim(hanbaitencd, ' 　')::varchar(5) as hanbaitencd,
        rtrim(hanbaitenname, ' 　')::varchar(5) as hanbaitenname,
        ldts,
        rank() over (partition by hanbaitencd order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3210') }}
)
select * from stg_hanbaitenmaster
where aggkey = 1
