with
    tmp20_dm_vinhis_nyukodetail as (
        select * from {{ ref("tmp20_dm_vinhis_nyukodetail") }}
    ),
    stg_hanbaitenmaster as (
        select
            hanbaitencd, -- 入庫販売店コード
            hanbaitenname -- 入庫販売店名称
        from {{ ref("stg_hanbaitenmaster") }} -- 販売店マスタ
    )
select
    tmp20_dm_vinhis_nyukodetail.syadai_kt, -- 車台型式
    tmp20_dm_vinhis_nyukodetail.frmno, -- フレームNo
    tmp20_dm_vinhis_nyukodetail.nyukohanbaitencd, -- 入庫販売店コード
    stg_hanbaitenmaster.hanbaitenname, -- 入庫販売店名称
    tmp20_dm_vinhis_nyukodetail.uketsuketenpocd, -- 受付店舗コード
    tmp20_dm_vinhis_nyukodetail.nyukokbn, -- 入庫区分
    tmp20_dm_vinhis_nyukodetail.value, -- 入庫区分名
    tmp20_dm_vinhis_nyukodetail.nyukoyoteiymd, -- 入庫予定日
    tmp20_dm_vinhis_nyukodetail.uketsukeymd, -- 受付日
    tmp20_dm_vinhis_nyukodetail.soukoukm, -- 走行km
    tmp20_dm_vinhis_nyukodetail.jutyuno, -- 受注No
    tmp20_dm_vinhis_nyukodetail.seisanymd, -- 精算年月日
    tmp20_dm_vinhis_nyukodetail.nyukono -- 入庫番号
from tmp20_dm_vinhis_nyukodetail
left outer join stg_hanbaitenmaster on tmp20_dm_vinhis_nyukodetail.nyukohanbaitencd = stg_hanbaitenmaster.hanbaitencd
