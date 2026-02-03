with urn as (
    select
        coalesce(syasyu, '') as syasyu,             --車種コード
        coalesce(haisya_kt, '') as haisya_kt,       --配車型式
        null as r_sfx_code,                         --SFXコード
        coalesce(spec200, '') as spec200,           --SPEC200桁組合せ
        spec200_siyo,                               --SPEC対応4桁仕様
        coalesce(int_cd, '') as int_cd,             --内張コード
        int_cd_iromei,                              --内張色
        coalesce(ext_cd, '') as ext_cd,              --外鈑色コード
        ext_cd_iromei,                              --外鈑色
        coalesce(dest_cd, '') as dest_cd,           --仕向地コード
        dest,                                       --仕向国
        coalesce(koujyou_cd, '') as koujyou_cd,     --工場コード
        coalesce(eng_kt, '') as eng_kt,             --エンジン型式
        coalesce(psc, '') as psc,                   --PSC
        coalesce(o_idline, '') as o_idline,         --アイデントライン
        coalesce(sk_y, '') as sk_y,                 --終検日年
        coalesce(sk_m, '') as sk_m,                 --終検日月
        count(*) as daisu,                          --台数
        '1' as naiji_flg                            --内示実績FLG
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