with
    tmp30 as (
        select * from {{ ref('tmp30_dm_vinhis_yohin') }}
    ),
    stg_katashikihenkanmaster_pixy as (
        select
            syameino, -- 用品車名No
            ctlkata, --CTL型式
            hanbaicd --販売ｺｰﾄﾞ
        from {{ ref('stg_katashikihenkanmaster_pixy') }} -- 型式変換マスター
    )
select
    tmp30.*,
    stg_katashikihenkanmaster_pixy.syameino
from tmp30
left outer join stg_katashikihenkanmaster_pixy
on replace(rtrim(tmp30.hkata),'-','') = replace(stg_katashikihenkanmaster_pixy.ctlkata || replace( stg_katashikihenkanmaster_pixy.hanbaicd,'-',''),' ','')