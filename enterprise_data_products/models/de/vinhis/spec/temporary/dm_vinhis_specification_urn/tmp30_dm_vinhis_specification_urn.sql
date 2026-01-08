with t20 as (   -- 中間20_URN装備(ALL)
    select
        urn,                -- URN
        dfsc,               -- DFSC/EDNO
        sno,                -- 仕様書NO
        ctlkata,            -- コントロール型式
        carname,            -- 車名
        figure,             -- 荷姿
        unittype,           -- ユニット区分
        equipmentline,      -- 架装ライン
        scndasmvtp,         -- 架装車両区分
        offopttype,         -- オフOPT区分
        importduty,         -- 再輸出区分
        discsign,           -- 識別記号
        ordcycl,            -- オーダーサイクル
        odrtype,            -- オーダータイプ
        vehcategorycode,    -- 車両識別コード
        syasyu,             -- 車種
        spec,               -- SPEC200桁組合せ
        intcode,            -- 内張コード
        extcode,            -- 外鈑色コード
        destcode,           -- 仕向地コード
        pscexlk,            -- PSC
        plantcode,          -- 工場コード
                            -- エンジン型式(生産管理)
                            -- 車両工場名(日本語)
        idline,             -- アイデントライン
        sk_y,               -- 終検日年
        sk_m,               -- 終検日月
        loj_y,              -- ラインオフ実績日年
        loj_m,              -- ラインオフ実績日月
        kata,               -- 呼称型式
        enginekata,         -- エンジン型式
        veh_plnt_code       -- 車両工場コード
	from {{ref('tmp20_dm_vinhis_specification_urn')}}
), alc as (     -- ALC工場コード
    select
        psc_alccode,        -- PSC1桁＆工場コード
        psc_alcname         -- PSC1桁＆工場名
    from {{source('common_tbl_public','raw_m_hostalc_pasc_plantcode')}}
), skm as (     -- 車両工場名称
    select
        table_data_id,      -- テーブルデータID
        value_ja,           -- 表示名(日)
        --right(value_ja,(len(value_ja) - charindex(':',value_ja))),
        value_en            -- 表示名(英)
        --right(value_en,(len(value_en) - charindex(':',value_en)))
    from {{source('common_tbl_db_iqas_name_convert','raw_mst_041veh_plnt_code_name')}}
), col as (     -- カラーNO
    select
        gclrno,             -- カラーNo
        iromei              -- 色名
    from {{ref('stg_color_no')}}
), km as (      -- 国マスター
    select 
        r_country_code,     -- 国コード
        r_country_name      -- 国名
    from {{source('supplydemand_db_public','raw_m_cuad001')}}
)
select
    t20.*,                              -- t20の全項目
    alc.psc_alcname,                    -- PSC1桁＆工場名
    skm.value_ja,                       -- 表示名(日)
    skm.value_en,                       -- 表示名(英)
    inc.iromei as int_cd_iromei,        -- 内張色名
    outc.iromei as ext_cd_iromei,       -- 外鈑色名
    km.r_country_name as dest           -- 国名
from t20                -- 中間20_URN装備(ALL)
left join alc           -- ALC工場コード
on (
    concat(t20.pscexlk, t20.plantcode) = alc.psc_alccode
)
left join skm           -- 車両工場名称
on (
    t20.veh_plnt_code = skm.table_data_id
)
left join col as inc    -- カラーNO(内張)
on (
    trim(t20.intcode) = trim(inc.gclrno)
)
left join col as outc   -- カラーNO(外鈑)
on (
    trim(t20.extcode) = trim(outc.gclrno)
)
left join km            -- 国マスター
on (
    t20.destcode = km.r_country_code
)