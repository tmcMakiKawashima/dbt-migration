with t60 as (
    select
        left(lodate,4) as sk_y,      -- 終検日年
        substr(lodate,5,2) as  sk_m, -- 終検日月
        spec as spec, -- スペック
        intcode as intcode, -- 内張コード
        extcode as extcode, -- 外鈑色コード
        destcode as destcode, -- 仕向地コード
        plantcode as plantcode, -- 工場コード
        pscexlk as pscexlk, -- PSC(外部連携用)
        idline as idline, -- アイデントライン
        syasyu as syasyu, -- 車種コード
        ctlkata as ctlkata -- コントロール型式
	from {{source('katashiki_db_spec','raw_tmp60_dm_siyo_seisan_daisu_test')}} as t51
  {% raw %}
    --from {{ref('tmp60_dm_siyo_seisan_daisu')}}
  {% endraw %}
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
    from {{source('engineering_db_public','raw_stg_color_no')}}
  {% raw %}
    --from {{ref('stg_color_no')}}
  {% endraw %}
), km as (
    select
        r_country_code, -- 国コード
        r_country_name  -- 国名
    from {{source('supplydemand_db_public','raw_m_cuad001')}})
select
    t60.syasyu,
    sksk.kata,
    sksk.enginekata,
    t60.sk_y,
    t60.sk_m,
    t60.spec,
    t60.intcode,
    inc.iromei as int_cd_iromei,
    t60.extcode,
    outc.iromei as ext_cd_iromei,
    t60.destcode as dest_cd,
    km.r_country_name as dest,
    t60.plantcode,
    t60.pscexlk,
    t60.idline,
    count(*) as daisu
from t60
left join sksk
on (
    t60.syasyu = sksk.syasyu
and t60.ctlkata = sksk.ctlkata
)
left join col as inc
on (
    t60.intcode = inc.gclrno
)
left join col as outc
on (
    t60.extcode = outc.gclrno
)
left join km as km
on (
    t60.destcode = km.r_country_code
)
group by
    t60.syasyu,
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