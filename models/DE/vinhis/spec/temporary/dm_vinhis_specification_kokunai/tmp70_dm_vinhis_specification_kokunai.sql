-- データ結合７
with
    tmp60 as (select * from {{ ref("tmp60_dm_vinhis_specification_kokunai") }}),
    eiji_syasyu as (
        select
            daibun_cd, -- 大分類コード
            sai_kana_name, -- スペック名称カナ
            saimoku_cd_std as saimoku_cd_std_eiji_syasyu, -- 細目コード名寄せ
            sai_catalog_name as sai_catalog_name_eiji_syasyu, -- 細目カタログ名称
        from {{ ref("stg_mst_vinhis_specification_nameconvert") }} -- 装備名寄せマスタ
        where sai_eiji_name <> '' and syasyu_cd <> '' -- 英字名称あり、車種コード指定あり
    ),
    kana_syasyu as (
        select
            daibun_cd, -- 大分類コード
            sai_kana_name, -- スペック名称カナ
            saimoku_cd_std as saimoku_cd_std_kana_syasyu, -- 細目コード名寄せ
            sai_catalog_name as sai_catalog_name_kana_syasyu, -- 細目カタログ名称
        from {{ ref("stg_mst_vinhis_specification_nameconvert") }} -- 装備名寄せマスタ
        where sai_kana_name <> '' and syasyu_cd <> '' -- カナ名称あり、車種コード指定あり
    ),
    eiji as (
        select
            daibun_cd, -- 大分類コード
            sai_kana_name, -- スペック名称カナ
            saimoku_cd_std as saimoku_cd_std_eiji, -- 細目コード名寄せ
            sai_catalog_name as sai_catalog_name_eiji, -- 細目カタログ名称
        from {{ ref("stg_mst_vinhis_specification_nameconvert") }} -- 装備名寄せマスタ
        where sai_eiji_name <> '' and syasyu_cd = '*' -- 英字名称あり、車種コード指定なし
    ),
    kana as (
        select
            daibun_cd, -- 大分類コード
            sai_kana_name, -- スペック名称カナ
            saimoku_cd_std as saimoku_cd_std_kana, -- 細目コード名寄せ
            sai_catalog_name as sai_catalog_name_kana, -- 細目カタログ名称
        from {{ ref("stg_mst_vinhis_specification_nameconvert") }} -- 装備名寄せマスタ
        where sai_kana_name <> '' and syasyu_cd = '*' -- かな名称あり、車種コード指定なし
    )
select
    tmp60.*,
    eiji_syasyu.* exclude (daibun_cd, sai_kana_name),
    kana_syasyu.* exclude (daibun_cd, sai_kana_name),
    eiji.* exclude (daibun_cd, sai_kana_name),
    kana.* exclude (daibun_cd, sai_kana_name)
from tmp60
left outer join eiji_syasyu
  on tmp60.daibun_cd = eiji_syasyu.daibun_cd
 and tmp60.sai_kana_name = eiji_syasyu.sai_kana_name
left outer join kana_syasyu
  on tmp60.daibun_cd = kana_syasyu.daibun_cd
 and tmp60.sai_kana_name = kana_syasyu.sai_kana_name
left outer join eiji
  on tmp60.daibun_cd = eiji.daibun_cd
 and tmp60.sai_kana_name = eiji.sai_kana_name
left outer join kana
  on tmp60.daibun_cd = kana.daibun_cd
 and tmp60.sai_kana_name = kana.sai_kana_name