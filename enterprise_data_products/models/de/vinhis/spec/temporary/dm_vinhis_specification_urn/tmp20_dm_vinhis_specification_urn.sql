with t10 as (
-- 中間10_URN装備(ALL)
    select
        urn,                                        -- URN
        dfsc,                                       -- DFSC/EDNO
        sno,                                        -- 仕様書NO
        ctlkata,                                    -- コントロール型式
        carname,                                    -- 車名
        figure,                                     -- 荷姿
        unittype,                                   -- ユニット区分
        equipmentline,                              -- 架装ライン
        scndasmvtp,                                 -- 架装車両区分
        offopttype,                                 -- オフOPT区分
        importduty,                                 -- 再輸出区分
        discsign,                                   -- 識別記号
        ordcycl,                                    -- オーダーサイクル
        odrtype,                                    -- オーダータイプ
        vehcategorycode,                            -- 車両識別コード
        syasyu,                                     -- 車種コード
        spec,                                       -- SPEC200桁組合せ
        intcode,                                    -- 内張コード
        extcode,                                    -- 外鈑色コード
        destcode,                                   -- 仕向地コード
        pscexlk,                                    -- PSC
        plantcode,                                  -- 工場コード
        idline,                                     -- アイデントライン
        left(lodate,4)::varchar(4) as sk_y,         -- 終検日年
        substr(lodate,5,2)::varchar(2) as sk_m,     -- 終検日月
        left(lodate,4)::varchar(4) as loj_y,        -- ラインオフ実績日年
        substr(lodate,5,2)::varchar(2) as loj_m     -- ラインオフ実績日月
	from {{ref('tmp10_dm_vinhis_specification_urn')}}
), sksk as(
-- 車種型式車両工場
    select
        syasyu,                                     -- 車種コード
        ktfgo,                                      -- 生産場所(工程符号)
        kata,                                       -- 呼称型式
        ctlkata,                                    -- コントロール型式
        enginekata,                                 -- エンジン型式
        ktfgomeijp,                                 -- 工程符号名称(和)
        ktfgomeien                                  -- 工程符号名称(英)
    from {{source('katashiki_db_basespec','raw_dm_syasyu_kata_sijino_plant')}}
), kh2 as (
-- 抽出結果_工場変換2桁
    select
        veh_plnt_code,                              -- 車両工場コード
        ktfgo                                       -- 工程符号
    from {{source('engineering_db_public','raw_m_koujyomaster')}}
    where length(ktfgo) = 2
), kh3 as (
-- 抽出結果_工場変換3桁
    select
        veh_plnt_code,                              -- 車両工場コード
        ktfgo                                       -- 工程符号
    from {{source('engineering_db_public','raw_m_koujyomaster')}}
    where length(ktfgo) = 3
)
select
    t10.*,                                                              -- t10の全項目
    sksk.* exclude(syasyu,ctlkata),                                     -- skskの車種コード、コントロール型式を除いた項目
    coalesce(kh3.veh_plnt_code, kh2.veh_plnt_code) as veh_plnt_code     -- 車両工場コード
from t10        -- 中間10_URN装備(ALL)
left join sksk  -- 車種型式車両工場
on (
    t10.syasyu = sksk.syasyu
    and t10.ctlkata = sksk.ctlkata
)
left join kh3   -- 抽出結果_工場変換3桁
on(
    substr(sksk.ktfgo,1,3) = kh3.ktfgo
)
left join kh2   -- 抽出結果_工場変換2桁
on(
    substr(sksk.ktfgo,1,2) = kh2.ktfgo
    and kh3.ktfgo is null
)