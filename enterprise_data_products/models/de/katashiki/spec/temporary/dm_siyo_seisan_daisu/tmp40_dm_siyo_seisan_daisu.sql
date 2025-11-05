with t4 as (
    select
        syasyu, -- 車種コード
        haisya_kt, -- 配車型式
        spec200, -- SPEC200桁組合せ
        max(spec200_siyo) as spec200_siyo, -- SPEC対応4桁仕様
        coalesce(int_cd, '') as int_cd, -- 内張コード
        max(int_cd_iromei) as int_cd_iromei, -- 内張名
        coalesce(ext_cd, '') as ext_cd, -- 鈑色コード
        max(ext_cd_iromei) as ext_cd_iromei, -- 外鈑色名
        coalesce(dest_cd, '') as dest_cd, -- 仕向地コード
        max(dest) as dest, -- 仕向地
        coalesce(koujyou_cd, '') as koujyou_cd, -- 工場コード
        coalesce(eng_kt, '') as eng_kt, -- エンジン型式（生産管理）
        coalesce(prodkuni_cd, '') as prodkuni_cd, -- 生産国コード
        coalesce(psc, '') as psc, -- PSC
        coalesce(o_idline, '') as o_idline, -- アイデントライン
        coalesce(sk_y, '') as sk_y, -- 終検日年
        coalesce(sk_m, '') as sk_m, -- 終検日月
        count(*)::number(13,0) as daisu, -- 台数
        '0' as naiji_flg -- 内示実績FLG
    from
        {{source('vinhis_db_spec','raw_dm_vinhis_spec200_allsalecar')}}
    group by
        syasyu,
        haisya_kt,
        spec200,
        int_cd,
        ext_cd,
        dest_cd,
        koujyou_cd,
        eng_kt,
        prodkuni_cd,
        psc,
        o_idline,
        sk_y,
        sk_m
)
select * from t4