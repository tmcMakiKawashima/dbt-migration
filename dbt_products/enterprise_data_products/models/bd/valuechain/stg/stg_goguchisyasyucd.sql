with stg_goguchisyasyucd as (
    select
        kbn::varchar(1) as kbn, --なし C,U,Dのメンテ区分
        syasyug::varchar(4) as syasyu_cd, --なし
        rtrim(syameino, ' 　')::varchar(3) as yohinsyamei, --右ブランク
        try_to_timestamp_ntz(touroku,'yyyymmdd') as touroku, --なし
        try_to_timestamp_ntz(kousin,'yyyymmdd') as kousin, --なし
        tantou::varchar(7) as tantou, --なし
        ldts, --B層取込日時
        row_number() over (partition by syasyu_cd, yohinsyamei order by ldts desc) aggkey
    from {{ ref('substr_tpjfva40') }}
)
select * exclude(kbn,aggkey)
from stg_goguchisyasyucd
where aggkey = 1 and kbn in ('C','U')
