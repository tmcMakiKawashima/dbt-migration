with t40 as (   -- 中間40_URN装備(ALL)
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
        dest,                                   -- 国名
        keta_no,                                -- 桁番号
        kigo                                    -- 記号
    from {{ref('tmp40_dm_vinhis_specification_urn')}}
), sh as (      -- 仕様変換マスタ
    select
        syasyu,                                 -- 車種コード
        s1keta,                                 -- spec桁
        s1kigo,                                 -- spec記号
        siyoudai4,                              -- 仕様コード(4桁)大分類
        siyousai4                               -- 仕様コード(4桁)細目
    from {{ref('stg_siyouhenkan')}}
)
select
    -- どちらか
    t40.* exclude(keta_no,kigo),                                                -- 桁番号、記号を除いたt40の項目
    listagg(sh.siyoudai4 || sh.siyousai4,'')
        within group(order by t40.keta_no)::varchar(800) as spec200_siyou       -- SPEC対応4桁仕様
from t40        -- 中間40_URN装備(ALL)
left join sh    -- 仕様変換マスタ
on (
    t40.syasyu = sh.syasyu
    and to_number(t40.keta_no) = to_number(sh.s1keta)
    and t40.kigo = sh.s1kigo
)