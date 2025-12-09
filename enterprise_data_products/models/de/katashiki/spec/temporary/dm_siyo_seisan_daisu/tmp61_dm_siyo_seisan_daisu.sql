with t60 as (
    select
        left(lodate,4)::varchar(4) as sk_y,      -- 終検日年
        substr(lodate,5,2)::varchar(2) as sk_m, -- 終検日月
        spec,  -- スペック
        intcode,  -- 内張コード
        extcode,  -- 外鈑色コード
        destcode,  -- 仕向地コード
        plantcode,  -- 工場コード
        pscexlk,  -- PSC(外部連携用)
        idline,  -- アイデントライン
        syasyu,  -- 車種コード
        ctlkata -- コントロール型式
	from {{ref('tmp60_dm_siyo_seisan_daisu')}} as t51
), sksk as (
    select
        syasyu,    -- 車種コード
        kata,      -- 配車型式
        ctlkata,   -- コントロール型式
        enginekata -- エンジン型式
    from {{source('katashiki_db_basespec','raw_dm_syasyu_kata_sijino_plant')}}
), col as (
    select
        gclrno, -- カラーNo
        iromei  -- 色名
    from {{ref('stg_color_no')}}
), km as (
    select
        r_country_code, -- 国コード
        r_country_name  -- 国名
    from {{source('supplydemand_db_public','raw_m_cuad001')}})
select
    t60.* exclude(ctlkata),
    sksk.kata,
    sksk.enginekata,
    inc.iromei as int_cd_iromei,
    outc.iromei as ext_cd_iromei,
    km.r_country_name,
    count(*)::number(13,0) as daisu
from t60
left join sksk
on (
    t60.syasyu = sksk.syasyu
and t60.ctlkata = sksk.ctlkata
)
left join col as inc
on (
    trim(t60.intcode) = trim(inc.gclrno)
)
left join col as outc
on (
    trim(t60.extcode) = trim(outc.gclrno)
)
left join km as km
on (
    t60.destcode = km.r_country_code
)
group by
    t60.syasyu,
    sksk.kata,
    sksk.enginekata,
    t60.sk_y,
    t60.sk_m,
    t60.spec,
    t60.intcode,
    inc.iromei,
    t60.extcode,
    outc.iromei,
    t60.destcode,
    km.r_country_name,
    t60.plantcode,
    t60.pscexlk,
    t60.idline