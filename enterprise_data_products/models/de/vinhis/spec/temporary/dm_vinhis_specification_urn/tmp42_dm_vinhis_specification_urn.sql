with t30 as (
-- 中間30_URN装備(ALL)
    select
        urn,                    -- URN
        dfsc,                   -- DFSC/EDNO
        sno,                    -- 仕様書NO
        ctlkata,                -- コントロール型式
        carname,                -- 車名
        figure,                 -- 荷姿
        unittype,               -- ユニット区分
        equipmentline,          -- 架装ライン
        scndasmvtp,             -- 架装車両区分
        offopttype,             -- オフOPT区分
        importduty,             -- 再輸出区分
        discsign,               -- 識別記号
        ordcycl,                -- オーダーサイクル
        odrtype,                -- オーダータイプ
        vehcategorycode,        -- 車両識別コード
        syasyu,                 -- 車種コード
        spec,                   -- SPEC200桁組合せ
        intcode,                -- 内張コード
        extcode,                -- 外鈑色コード
        destcode,               -- 仕向地コード
        pscexlk,                -- PSC
        plantcode,              -- 工場コード
        idline,                 -- アイデントライン
        sk_y,                   -- 終検日年
        sk_m,                   -- 終検日月
        loj_y,                  -- ラインオフ実績日年
        loj_m,                  -- ラインオフ実績日月
        ktfgo,                  -- 生産場所(工程符号)
        kata,                   -- 呼称型式
        enginekata,             -- エンジン型式
        ktfgomeijp,             -- 工程符号名称(和)
        ktfgomeien,             -- 工程符号名称(英)
        veh_plnt_code,          -- 車両工場コード
        psc_alcname,            -- PSC1桁＆工場名
        veh_plnt_code_name,     -- 車両工場名(日本語)
        veh_plnt_code_name_en,  -- 車両工場名(英語)
        int_cd_iromei,          -- 内張色
        ext_cd_iromei,          -- 外鈑色
        r_country_name          -- 仕向国
	from {{ref('tmp30_dm_vinhis_specification_urn')}}
), t41 as (
-- 中間41_URN装備(ALL)
    select
        syasyu,                 -- 車種コード
        kata,                   -- 呼称型式
        enginekata,             -- エンジン型式
        sk_y,                   -- 終検日年
        sk_m,                   -- 終検日月
        spec,                   -- SPEC200桁組合せ
        intcode,                -- 内張コード
        extcode,                -- 外鈑色コード
        destcode,               -- 仕向地コード
        plantcode,              -- 工場コード
        pscexlk,                -- PSC
        idline,                 -- アイデントライン
        spec200_siyo            -- SPEC対応4桁仕様
	from {{ref('tmp41_dm_vinhis_specification_urn')}}
)
select
    t30.*,                      -- t30の全項目
    t41.spec200_siyo            -- SPEC対応4桁仕様
from t30        -- 中間30_URN装備(ALL)
left join t41   -- 中間41_URN装備(ALL)
on (
    t30.syasyu = t41.syasyu
    and t30.kata = t41.kata
    and t30.enginekata = t41.enginekata
    and t30.sk_y = t41.sk_y
    and t30.sk_m = t41.sk_m
    and t30.spec = t41.spec
    and t30.intcode = t41.intcode
    and t30.extcode = t41.extcode
    and t30.destcode = t41.destcode
    and t30.plantcode = t41.plantcode
    and t30.pscexlk = t41.pscexlk
    and t30.idline = t41.idline
)