with t40 as (   -- 中間40_URN装備(ALL)
    select
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
        idline,                                 -- アイデントライン
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
    t40.syasyu,                                                             -- 車種コード
    t40.kata,                                                               -- 呼称型式
    t40.enginekata,                                                         -- エンジン型式
    t40.sk_y,                                                               -- 終検日年
    t40.sk_m,                                                               -- 終検日月
    t40.spec,                                                               -- SPEC200桁組合せ
    t40.intcode,                                                            -- 内張コード
    t40.extcode,                                                            -- 外鈑色コード
    t40.destcode,                                                           -- 仕向地コード
    t40.plantcode,                                                          -- 工場コード
    t40.pscexlk,                                                            -- PSC
    t40.idline,                                                             -- アイデントライン
    listagg(sh.siyoudai4 || sh.siyousai4,'')
        within group(order by t40.keta_no)::varchar(800) as spec200_siyou   -- SPEC対応4桁仕様
from t40        -- 中間40_URN装備(ALL)
left join sh    -- 仕様変換マスタ
on (
    t40.syasyu = sh.syasyu
    and to_number(t40.keta_no) = to_number(sh.s1keta)
    and t40.kigo = sh.s1kigo
)
group by
    t40.syasyu,
    t40.kata,
    t40.enginekata,
    t40.sk_y,
    t40.sk_m,
    t40.spec,
    t40.intcode,
    t40.extcode,
    t40.destcode,
    t40.plantcode,
    t40.pscexlk,
    t40.idline
