with urn as (
    select
        syasyu,               --車種コード
        haisya_kt,            --配車型式
        null as r_sfx_code,   --SFXコード
        eng_kt,               --エンジン型式
        sk_y,                 --終検日年
        sk_m,                 --終検日月
        spec200,              --SPEC200桁組合せ
        spec200_siyo,         --SPEC対応4桁仕様
        int_cd,               --内張コード
        int_cd_iromei,        --内張色
        ext_cd,               --外鈑色コード
        ext_cd_iromei,        --外鈑色
        dest_cd,              --仕向地コード
        dest,                 --仕向国
        koujyou_cd,           --工場コード
        psc,                  --PSC
        o_idline,             --アイデントライン
        count(*) as daisu,    --台数
        '1' as naiji_flg      --内示実績FLG
    from {{ref('dm_vinhis_specification_urn')}}
    where concat(sk_y, sk_m) >= to_varchar(current_date(), 'yyyymm')
    group by
        syasyu,
        haisya_kt,
        eng_kt,
        sk_y,
        sk_m,
        spec200,
        spec200_siyo,
        int_cd,
        int_cd_iromei,
        ext_cd,
        ext_cd_iromei,
        dest_cd,
        dest,
        koujyou_cd,
        psc,
        o_idline
)
select * from urn