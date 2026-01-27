with t20 as (
-- 中間20_URN装備(ALL)
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
        syasyu,             -- 車種コード
        spec,               -- SPEC200桁組合せ
        intcode,            -- 内張コード
        extcode,            -- 外鈑色コード
        destcode,           -- 仕向地コード
        pscexlk,            -- PSC
        plantcode,          -- 工場コード
        idline,             -- アイデントライン
        sk_y,               -- 終検日年
        sk_m,               -- 終検日月
        loj_y,              -- ラインオフ実績日年
        loj_m,              -- ラインオフ実績日月
        ktfgo,              -- 生産場所(工程符号)
        kata,               -- 呼称型式
        enginekata,         -- エンジン型式
        ktfgomeijp,         -- 工程符号名称(和)
        ktfgomeien,         -- 工程符号名称(英)
        veh_plnt_code       -- 車両工場コード
    from {{source('vinhis_db_spec','raw_tmp20_dm_vinhis_specification_urn')}}
{% raw %}
	--from {{ref('tmp20_dm_vinhis_specification_urn')}}
{% endraw %}
), alc as (
-- ALC工場コード
    select
        psc_alccode,        -- PSC1桁＆工場コード
        psc_alcname         -- PSC1桁＆工場名
    --from {{source('common_tbl_db_public','raw_m_hostalc_psc_plantcode')}}
    from {{source('common_tbl_db_public','raw_m_hostalc_psc_plantcode_test')}}
), skm as (
-- 車両工場名称
    select
        table_data_id,                                                                      -- テーブルデータID
        right(value_ja,(len(value_ja) - charindex(':',value_ja))) as veh_plnt_code_name,    -- 表示名(日)
        right(value_en,(len(value_en) - charindex(':',value_en))) as veh_plnt_code_name_en  -- 表示名(英)
    --from {{source('common_tbl_db_iqas_name_convert','raw_mst_041veh_plnt_code_name')}}
    from {{source('common_tbl_db_iqas_name_convert','raw_mst_041veh_plnt_code_name_test')}}
), inc as (
-- カラーNO(内張)
    select
        gclrno,                     -- カラーNo
        iromei as int_cd_iromei     -- 色名
    from {{source('engineering_db_public','raw_stg_color_no')}}
{% raw %}
	--from {{ref('stg_color_no')}}
{% endraw %}
), outc as (
-- カラーNO(外鈑)
    select
        gclrno,                     -- カラーNo
        iromei as ext_cd_iromei     -- 色名
    from {{source('engineering_db_public','raw_stg_color_no')}}
{% raw %}
	--from {{ref('stg_color_no')}}
{% endraw %}
), km as (
-- 国マスター
    select 
        r_country_code,             -- 国コード
        r_country_name              -- 国名
    --from {{source('supplydemand_db_public','raw_m_cuad001')}}
    from {{source('supplydemand_db_public','raw_m_cuad001_test')}}
)
select
    t20.*,                              -- t20の全項目
    alc.* exclude(psc_alccode),         -- alcのPSC1桁＆工場コードを除いた項目
    skm.* exclude(table_data_id),       -- skmのテーブルデータIDを除いた項目
    inc.* exclude(gclrno),              -- incのカラーNoを除いた項目
    outc.* exclude(gclrno),             -- outcのカラーNoを除いた項目
    km.* exclude(r_country_code)        -- kmの国コードを除いた項目
from t20         -- 中間20_URN装備(ALL)
left join alc    -- ALC工場コード
on (
    concat(t20.pscexlk, t20.plantcode) = alc.psc_alccode
)
left join skm    -- 車両工場名称
on (
    t20.veh_plnt_code = skm.table_data_id
)
left join inc    -- カラーNO(内張)
on (
    trim(t20.intcode) = trim(inc.gclrno)
)
left join outc   -- カラーNO(外鈑)
on (
    trim(t20.extcode) = trim(outc.gclrno)
)
left join km     -- 国マスター
on (
    t20.destcode = km.r_country_code
)