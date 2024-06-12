with
    tmp10_dm_vinhis_nyukodetail as (
        select * from {{ ref("tmp10_dm_vinhis_nyukodetail") }}
    ),
    stg_codekubun as (
        select
            key, -- 入庫区分
            value -- 入庫区分名
        from {{ ref("stg_codekubun") }} -- コード区分マスタ
        where codekbnid = '028'
    )
select
    tmp10_dm_vinhis_nyukodetail.syadai_kt, -- 車台型式
    tmp10_dm_vinhis_nyukodetail.frmno, -- フレームNo
    tmp10_dm_vinhis_nyukodetail.nyukohanbaitencd, -- 入庫販売店コード
    tmp10_dm_vinhis_nyukodetail.uketsuketenpocd, -- 受付店舗コード
    tmp10_dm_vinhis_nyukodetail.nyukokbn, -- 入庫区分
    stg_codekubun.value, -- 入庫区分名
    tmp10_dm_vinhis_nyukodetail.nyukoyoteiymd, -- 入庫予定日
    tmp10_dm_vinhis_nyukodetail.uketsukeymd, -- 受付日
    tmp10_dm_vinhis_nyukodetail.soukoukm, -- 走行km
    tmp10_dm_vinhis_nyukodetail.jutyuno, -- 受注No
    tmp10_dm_vinhis_nyukodetail.seisanymd, -- 精算年月日
    tmp10_dm_vinhis_nyukodetail.nyukono -- 入庫番号
from tmp10_dm_vinhis_nyukodetail
left outer join stg_codekubun on tmp10_dm_vinhis_nyukodetail.nyukokbn = stg_codekubun.key
