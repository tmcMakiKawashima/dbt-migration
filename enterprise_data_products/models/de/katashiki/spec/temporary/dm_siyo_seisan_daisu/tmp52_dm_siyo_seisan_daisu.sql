with t52 as (
    select
        t51.syasyu,                                         -- 車種ｺｰﾄﾞ
        t51.haisya_kt,                                      -- 配車型式
        max(t51.r_sfx_code) as r_sfx_code,                  -- SFX№
        max(t51.spec200) as spec200,                        -- SPEC200桁組合せ
        max(t51.spec200_siyo) as spec200_siyo,              -- SPEC対応4桁仕様
        max(t51.int_cd) as int_cd,                          -- 内張コード
        max(t51.int_cd_iromei) as int_cd_iromei,            -- 内張名
        max(t51.ext_cd) as ext_cd,                          -- 外鈑色コード
        max(t51.ext_cd_iromei) as ext_cd_iromei,            -- 外鈑色名
        t51.dest_cd,                                        -- 仕向地コード
        max(t51.dest) as dest,                              -- 仕向国
        max(t51.koujyou_cd) as koujyou_cd,                  -- 工場コード
        max(t51.eng_kt) as eng_kt,                          -- エンジン型式
        max(t51.psc) as psc,                                -- PSC
        max(t51.o_idline) as o_idline,                      -- アイデントライン
        t51.sk_y,                                           -- 終検日年
        t51.sk_m,                                           -- 終検日月
        max(t51.daisu) as daisu,                            -- 台数
        max(t51.naiji_flg) as naiji_flg                     -- 内示実績FLG
	from {{source('katashiki_db_spec','raw_tmp51_dm_siyo_seisan_daisu_test')}} as t51
  {% raw %}
    --from {{ref('tmp51_dm_siyo_seisan_daisu')}}
  {% endraw %}
    group by
        syasyu,
        haisya_kt,
        dest_cd,
        sk_y,
        sk_m
)
select * from t52