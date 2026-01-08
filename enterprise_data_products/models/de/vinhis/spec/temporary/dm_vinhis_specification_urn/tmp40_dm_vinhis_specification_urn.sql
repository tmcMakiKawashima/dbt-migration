with t30 as (   -- 中間30_URN装備(ALL)
    select
        urn,                                    -- URN
        dfsc,                                   -- DFSC/EDNO
        sno,                                    -- 仕様書NO
        ctlkata,                                -- コントロール型式
        carname,                                -- 車名
        figure,                                 -- 荷姿
        unittype,                               -- ユニット区分
        equipmentline,                          -- 架装ライン
        scndasmvtp,                             -- 架装車両区分
        offopttype,                             -- オフOPT区分
        importduty,                             -- 再輸出区分
        discsign,                               -- 識別記号
        ordcycl,                                -- オーダーサイクル
        odrtype,                                -- オーダータイプ
        vehcategorycode,                        -- 車両識別コード
        syasyu,                                 -- 車種
        spec,                                   -- SPEC200桁組合せ
        intcode,                                -- 内張コード
        extcode,                                -- 外鈑色コード
        destcode,                               -- 仕向地コード
        pscexlk,                                -- PSC
        plantcode,                              -- 工場コード
                                                -- エンジン型式(生産管理)
        idline,                                 -- アイデントライン
        sk_y,                                   -- 終検日年
        sk_m,                                   -- 終検日月
        loj_y,                                  -- ラインオフ実績日年
        loj_m,                                  -- ラインオフ実績日月
        kata,                                   -- 呼称型式
        enginekata,                             -- エンジン型式
        veh_plnt_code,                          -- 車両工場コード
        psc_alcname,                            -- PSC1桁＆工場名
        value_ja,                               -- 表示名(日)
        value_en,                               -- 表示名(英)
        int_cd_iromei,                          -- 内張色名
        ext_cd_iromei,                          -- 外鈑色名
        dest                                    -- 国名
    from {{ref('tmp30_dm_vinhis_specification_urn')}}
), seq as(      -- SPECを200分割するためのシーケンス
    select
        seq4() + 1 as keta_no                   -- 桁番号
    from table(generator(rowcount => 200))
)
select
    t30.*,                                      -- t30の全項目
    seq.*,                                      -- 桁番号
    substr(t30.spec,seq.keta_no,1) as kigo      -- 記号
from t30        -- 中間30_URN装備(ALL)
cross join seq  -- SPECを200分割するためのシーケンス