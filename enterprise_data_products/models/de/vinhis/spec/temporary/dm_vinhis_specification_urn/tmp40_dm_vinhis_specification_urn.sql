with t30 as (
-- 抽出結果_中間30_重複排除
    select distinct
        syasyu,                                 -- 車種コード
        kata,                                   -- 呼称型式
        enginekata,                             -- エンジン型式
        sk_y,                                   -- 終検日年
        sk_m,                                   -- 終検日月
        spec,                                   -- SPEC200桁組合せ
        intcode,                                -- 内張コード
        extcode,                                -- 外鈑色コード
        destcode,                               -- 仕向地コード
        plantcode,                              -- 工場コード
        pscexlk,                                -- PSC
        idline                                  -- アイデントライン
	from {{ref('tmp30_dm_vinhis_specification_urn')}}
), seq as(
-- SPECを200分割するためのシーケンス
    select
        seq4() + 1 as keta_no                   -- 桁番号
    from table(generator(rowcount => 200))
)
select
    t30.*,                                      -- t30の全項目
    seq.*,                                      -- 桁番号
    substr(t30.spec,seq.keta_no,1) as kigo      -- 記号
from t30        -- 抽出結果_中間30_重複排除
cross join seq  -- SPECを200分割するためのシーケンス