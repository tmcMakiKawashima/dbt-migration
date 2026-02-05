with t42 as (
-- 中間42_URN装備(ALL)
    select
        coalesce(urn,'') as urn,                    -- URN
        dfsc,                                       -- DFSC/EDNO
        sno,                                        -- 仕様書NO
        ctlkata,                                    -- コントロール型式
        carname,                                    -- 車名
        figure,                                     -- 荷姿
        unittype,                                   -- ユニット区分
        equipmentline,                              -- 架装ライン
        scndasmvtp,                                 -- 架装車両区分
        coalesce(lodate,'') as lodate,              -- ラインオフ計画日
        offopttype,                                 -- オフOPT区分
        importduty,                                 -- 再輸出区分
        discsign,                                   -- 識別記号
        ordcycl,                                    -- オーダーサイクル
        odrtype,                                    -- オーダータイプ
        vehcategorycode,                            -- 車両識別コード
        syasyu,                                     -- 車種コード
        kata as haisya_kt,                          -- 配車型式
        spec as spec200,                            -- SPEC200桁組合せ
        spec200_siyo,                               -- SPEC対応4桁仕様
        intcode as int_cd,                          -- 内張コード
        int_cd_iromei,                              -- 内張名
        extcode as ext_cd,                          -- 外鈑色コード
        ext_cd_iromei,                              -- 外鈑色名
        destcode as dest_cd,                        -- 仕向地コード
        r_country_name as dest,                     -- 仕向国
        coalesce(pscexlk,'') as psc,                -- PSC
        coalesce(plantcode,'') as koujyou_cd,       -- 工場コード
        psc_alcname as psc_koujyou_meisho,          -- PSC1桁＆工場名
        enginekata as eng_kt,                       -- エンジン型式(生産管理)
        veh_plnt_code,                              -- 車両工場コード
        veh_plnt_code_name,                         -- 車両工場名(日本語)
        veh_plnt_code_name_en,                      -- 車両工場名(英語)
        ktfgo as seisanbasyo,                       -- 生産場所(工程符号)
        ktfgomeijp,                                 -- 工程符号名称(和)
        ktfgomeien,                                 -- 工程符号名称(英)
        ''::varchar(3) as prodkuni_cd,              -- 生産国コード
        idline as o_idline,                         -- アイデントライン
        loj_y,                                      -- ラインオフ実績日年
        loj_m,                                      -- ラインオフ実績日月
        sk_y,                                       -- 終検日年
        sk_m,                                       -- 終検日月
        current_timestamp::timestamp_ntz(9) as ldts -- 現在日時
	from {{ref('tmp42_dm_vinhis_specification_urn')}}
)
select * from t42   -- 中間42_URN装備(ALL)