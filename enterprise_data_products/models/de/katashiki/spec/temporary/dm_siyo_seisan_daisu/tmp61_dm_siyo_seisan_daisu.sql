with t06 as (
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
		sayasyu as sayasyu, -- 車種コード
		ctlkata as ctlkata -- コントロール型式
    from {{ref('tmp60_dm_siyo_seisan_daisu')}}
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
), km as (
    select
		r_country_code,
		r_country_name
    from {{source('supplydemand_db_public','raw_m_cuad001')}})
select
	t06.sayasyu,
	sksk.kata,
	sksk.enginekata,
	t06.sk_y,
	t06.sk_m,
	t06.spec,
	t06.intcode,
	inc.iromei as int_cd_iromei,
	t06.extcode,
	outc.iromei as ext_cd_iromei,
	t06.destcode as dest_cd,
	km.r_country_name as dest,
	t06.plantcode,
	t06.pscexlk,
	t06.idline,
	count(*) as daisu
from t06
left join sksk
on (
	t06.sayasyu = sksk.syasyu
and t06.ctlkata = sksk.ctlkata
)
left join col as inc
on (
	t06.intcode = inc.gclrno
)
left join col as outc
on (
	t06.extcode = outc.gclrno
)
left join km as km
on (
	t06.destcode = km.r_country_code
)
group by
	t06.sayasyu,
	kata,
	enginekata,
	sk_y,
	sk_m,
	spec,
	intcode,
	int_cd_iromei,
	extcode,
	ext_cd_iromei,
	dest_cd,
	dest,
	plantcode,
	pscexlk,
	idline