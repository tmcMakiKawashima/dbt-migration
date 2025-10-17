with
    tmp20 as (
        select * from {{ ref('tmp20_dm_vinhis_nyukodetail') }}
    ),
    hanbaitenmaster as (
        select
            hanbaitencd, -- 販売店コード
            hanbaitenname --販売店名称
        from {{ ref('stg_hanbaitenmaster') }} -- 販売店マスタ
    )
select
    tmp20.*,
    hanbaitenmaster.* exclude (hanbaitencd)
from tmp20
left outer join hanbaitenmaster
  on tmp20.nyukohanbaitencd = hanbaitenmaster.hanbaitencd
