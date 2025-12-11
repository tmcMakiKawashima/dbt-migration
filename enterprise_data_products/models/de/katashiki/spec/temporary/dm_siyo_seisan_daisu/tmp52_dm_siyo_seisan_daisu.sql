with t52 as (
    select
        t51.syasyu,                                         -- 車種ｺｰﾄﾞ
        t51.haisya_kt,                                      -- 配車型式
        max(t51.r_sfx_code) as r_sfx_code,                  -- SFX№
        t51.spec200,                                        -- SPEC200桁組合せ
        max(t51.spec200_siyo) as spec200_siyo,              -- SPEC対応4桁仕様
        t51.int_cd,                                         -- 内張コード
        max(t51.int_cd_iromei) as int_cd_iromei,            -- 内張名
        t51.ext_cd,                                         -- 外鈑色コード
        max(t51.ext_cd_iromei) as ext_cd_iromei,            -- 外鈑色名
        t51.dest_cd,                                        -- 仕向地コード
        max(t51.dest) as dest,                              -- 仕向国
        t51.koujyou_cd,                                     -- 工場コード
        t51.eng_kt,                                         -- エンジン型式
        t51.psc,                                            -- PSC
        t51.o_idline,                                       -- アイデントライン
        t51.sk_y,                                           -- 終検日年
        t51.sk_m,                                           -- 終検日月
        max(t51.daisu) as daisu,                            -- 台数
        max(t51.naiji_flg) as naiji_flg                     -- 内示実績FLG
	  from {{ref('tmp51_dm_siyo_seisan_daisu')}} as t51
    group by
        syasyu,
        haisya_kt,
        spec200,
        int_cd,
        ext_cd,
        dest_cd,
        koujyou_cd,
        eng_kt,
        psc,
        o_idline,
        sk_y,
        sk_m
)
select * from t52