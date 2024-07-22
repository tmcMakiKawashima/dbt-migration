with stg_goguchisyasyucd as (
    select
        syasyug::varchar(4) as syasyu_cd, --なし
        rtrim(syameino, ' 　')::varchar(3) as yohinsyamei, --右ブランク
        try_to_timestamp_ntz(touroku,'yyyymmdd') as touroku, --なし
        try_to_timestamp_ntz(kousin,'yyyymmdd') as kousin, --なし
        tantou::varchar(7) as tantou, --なし
        ldts --B層取込日時
    from {{ ref('substr_tpjfva40') }}
)
select * from stg_goguchisyasyucd
where ldts = (select max(ldts) from stg_goguchisyasyucd)