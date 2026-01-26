with vh as(
    select
        syasyu,                                     -- 車種コード
        kata,                                       -- 配車型式
        spec,                                       -- スペック
        spec200_siyou,                              -- SPEC対応4桁仕様
        intcode,                                    -- 内張コード
        int_cd_iromei,                              -- 内張色名
        extcode,                                    -- 外鈑色コード
        ext_cd_iromei,                              -- 外版色名
        dest_cd,                                    -- 仕向地コード
        r_country_name,                             -- 国名
        plantcode,                                  -- 工場コード
        enginekata,                                 -- エンジン型式
        pscexlk,                                    -- PSC(外部連携用)
        sk_y,                                       -- 終検日年
        sk_m,                                       -- 終検日月
        idline                                      -- アイデントライン
    from {{ref('dm_vinhis_specification_urn')}}   -- 取得元がm_vinhis_specification_urnになる予定
)
select
    syasyu,                                     -- 車種コード
    kata,                                       -- 配車型式
    null::varchar(2) as r_sfx_code,
    spec,                                       -- スペック
    spec200_siyou,                              -- SPEC対応4桁仕様
    intcode,                                    -- 内張コード
    int_cd_iromei,                              -- 内張色名
    extcode,                                    -- 外鈑色コード
    ext_cd_iromei,                              -- 外版色名
    dest_cd,                                    -- 仕向地コード
    r_country_name,                             -- 国名
    plantcode,                                  -- 工場コード
    enginekata,                                 -- エンジン型式
    pscexlk,                                    -- PSC(外部連携用)
    idline,                                     -- アイデントライン
    sk_y,                                       -- 終検日年
    sk_m,                                       -- 終検日月
    '1' as naiji_flg,                           -- 内示実績FLG
    count(*)::number(13,0) as daisu             -- 台数
from vh
group by
    vh.syasyu,
    vh.kata,
    vh.enginekata,
    vh.sk_y,
    vh.sk_m,
    vh.spec,
    vh.spec200_siyou,
    vh.intcode,
    vh.int_cd_iromei,
    vh.extcode,
    vh.ext_cd_iromei,
    vh.dest_cd,
    vh.r_country_name,
    vh.plantcode,
    vh.pscexlk,
    vh.idline