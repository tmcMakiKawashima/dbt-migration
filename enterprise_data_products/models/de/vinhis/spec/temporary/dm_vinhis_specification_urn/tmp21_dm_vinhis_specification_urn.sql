with add_rnk as (
-- 工程符号紐づけ結果ランク付け
    select
        urn,                        -- URN
        dfsc,                       -- DFSC/EDNO
        sno,                        -- 仕様書NO
        ctlkata,                    -- コントロール型式
        carname,                    -- 車名
        figure,                     -- 荷姿
        unittype,                   -- ユニット区分
        equipmentline,              -- 架装ライン
        scndasmvtp,                 -- 架装車両区分
        lodate,                     -- ラインオフ計画日
        offopttype,                 -- オフOPT区分
        importduty,                 -- 再輸出区分
        discsign,                   -- 識別記号
        ordcycl,                    -- オーダーサイクル
        odrtype,                    -- オーダータイプ
        vehcategorycode,            -- 車両識別コード
        syasyu,                     -- 車種コード
        spec,                       -- SPEC200桁組合せ
        intcode,                    -- 内張コード
        extcode,                    -- 外鈑色コード
        destcode,                   -- 仕向地コード
        pscexlk,                    -- PSC
        plantcode,                  -- 工場コード
        idline,                     -- アイデントライン
        sk_y,                       -- 終検日年
        sk_m,                       -- 終検日月
        loj_y,                      -- ラインオフ実績日年
        loj_m,                      -- ラインオフ実績日月
        seisanbasyo,                -- 生産場所(工程符号)
        kata,                       -- 呼称型式
        enginekata,                 -- エンジン型式
        ktfgomeijp,                 -- 工程符号名称(和)
        ktfgomeien,                 -- 工程符号名称(英)
        veh_plnt_code,              -- 車両工場コード
        ktfgo,                      -- 工程符号
        -- pk単位で重複するレコードを特定条件で並び替えて昇順に採番してランク付けする
        row_number() over(
            partition by
                urn,
                lodate,
                pscexlk,
                plantcode
            order by
                case
                    -- 生産場所(工程符号)の先頭3桁と工程符号が一致する場合
                    when substr(seisanbasyo,1,3) = ktfgo then 0
                    -- 生産場所(工程符号)の先頭2桁と工程符号が一致する場合
                    when substr(seisanbasyo,1,2) = ktfgo then 1
                    -- 一致しない場合
                    else 2
                end,
                -- 車両工場コードの昇順
                veh_plnt_code
        ) as rnk                    -- ランク
	from {{ref('tmp20_dm_vinhis_specification_urn')}}
)
select
    add_rnk.* exclude(ktfgo, rnk)       -- add_rnkの工程符号とランクを除いた項目
from add_rnk    -- 工程符号紐づけ結果ランク付け
where add_rnk.rnk = 1                   -- ランクが1のレコードのみ抽出する