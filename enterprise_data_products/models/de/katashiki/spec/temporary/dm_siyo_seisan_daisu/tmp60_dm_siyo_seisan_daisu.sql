with mss as (
    select
		sno,
		syasyu,
		row_number() over(
			partition by sno
			order by mtdate desc
		) as rnk
	from {{source('supplydemand_db_public','raw_stg_syasyu_siyousho')}}
), ssua as (
    select
		carfamily as carfamily, -- 車種コード
        lodate as lodate, -- ラインオフ計画日
		spec as spec, -- スペック
		intcode as intcode, -- 内張コード
		extcode as extcode, -- 外鈑色コード
		destcode as destcode, -- 仕向地コード
		plantcode as plantcode, -- 工場コード
		pscexlk as pscexlk, -- PSC(外部連携用)
		idline as idline, -- アイデントライン
		ctlkata as ctlkata, -- コントロール型式
		sno as sno --仕様書NO
    from {{source('supplydemand_db_public','raw_stg_union_all_vehicle_specification_alc')}}
)
select
	coalesce(nullif(ssua.carfamily , ''), mss.syasyu) as sayasyu,
    ssua.lodate as lodate, -- ラインオフ計画日
	ssua.spec as spec, -- スペック
	ssua.intcode as intcode, -- 内張コード
	ssua.extcode as extcode, -- 外鈑色コード
	ssua.destcode as destcode, -- 仕向地コード
	ssua.plantcode as plantcode, -- 工場コード
	ssua.pscexlk as pscexlk, -- PSC(外部連携用)
	ssua.idline as idline, -- アイデントライン
	ssua.ctlkata as ctlkata -- コントロール型式
from ssua
left join mss
on (
	ssua.sno = mss.sno
and mss.rnk = 1
)