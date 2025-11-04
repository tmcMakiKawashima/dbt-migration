with ssua as (
    select
        left(lodate,4) as sk_y, -- 終検日年
		substr(lodate,5,2) as  sk_m, -- 終検日月
		spec as spec, -- スペック
		intcode as intcode, -- 内張コード
		extcode as extcode, -- 外鈑色コード
		destcode as destcode, -- 仕向地コード
		plantcode as plantcode, -- 工場コード
		pscexlk as pscexlk, -- PSC(外部連携用)
		idline as idline, -- アイデントライン
		carfamily as carfamily, -- 車種コード
		ctlkata as ctlkata -- コントロール型式
	from {{ref('union_all_vehicle_specification')}} 
), sksk as (
    select
		syasyu,
		kata,
		ctlkata,
		enginekata
    from {{source('katashiki_db_basespec','raw_dm_syasyu_kata_sijino_plant')}}
), col as (
    select
		gclrno,
		iromei
    from {{source('engineering_db_public','raw_stg_color_no')}}
    --from {{ref('stg_color_no')}}
), km as (
    select
		r_country_code,
		r_country_name
    from {{source('supplydemand_db_public','raw_m_cuad001')}})
select
	sksk.syasyu,
	sksk.kata,
	sksk.enginekata,
	ssua.sk_y,
	ssua.sk_m,
	ssua.spec,
	ssua.intcode,
	inc.iromei as int_cd_iromei,
	ssua.extcode,
	outc.iromei as ext_cd_iromei,
	ssua.destcode as dest_cd,
	km.r_country_name as dest,
	ssua.plantcode,
	ssua.pscexlk,
	ssua.idline
from ssua
left join sksk
on (
	ssua.carfamily = sksk.syasyu
and ssua.ctlkata = sksk.ctlkata
)
left join col as inc
on (
	ssua.intcode = inc.gclrno
)
left join col as outc
on (
	ssua.extcode = outc.gclrno
)
left join km as km
on (
	ssua.destcode = km.r_country_code
)