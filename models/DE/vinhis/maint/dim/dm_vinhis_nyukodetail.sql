with
    tmp30_dm_vinhis_nyukodetail as (
        select * from {{ ref("tmp30_dm_vinhis_nyukodetail") }}
    ),
    stg_hanbaitentenpomaster as (
        select
            hanbaitencd, -- 入庫販売店コード
            tenpocd, -- 受付店舗コード
            tenponame -- 受付店舗名称
        from {{ ref("stg_hanbaitentenpomaster") }} -- 販売店マスタ
    )
select
    tmp30_dm_vinhis_nyukodetail.syadai_kt as syadai_kt, -- 車台型式
    tmp30_dm_vinhis_nyukodetail.frmno as frm_no, -- フレームNo
    tmp30_dm_vinhis_nyukodetail.nyukohanbaitencd as nyuko_dlrcd, -- 入庫販売店コード
    tmp30_dm_vinhis_nyukodetail.hanbaitenname as nyuko_dlrcd_name, -- 入庫販売店名称
    tmp30_dm_vinhis_nyukodetail.uketsuketenpocd as uketuke_tenpo_cd, -- 受付店舗コード
    stg_hanbaitentenpomaster.tenponame as uketuke_tenpo_name, -- 受付店舗名称
    tmp30_dm_vinhis_nyukodetail.nyukokbn as nyuko_kbn, -- 入庫区分
    tmp30_dm_vinhis_nyukodetail.value as nyuko_kbn_name, -- 入庫区分名
    tmp30_dm_vinhis_nyukodetail.nyukoyoteiymd as nyuko_plan_date, -- 入庫予定日
    tmp30_dm_vinhis_nyukodetail.uketsukeymd as uketuke_date, -- 受付日
    tmp30_dm_vinhis_nyukodetail.soukoukm as soukou_km, -- 走行km
    tmp30_dm_vinhis_nyukodetail.jutyuno as jutyu_no, -- 受注No
    tmp30_dm_vinhis_nyukodetail.seisanymd as payment_date, -- 精算年月日
    tmp30_dm_vinhis_nyukodetail.nyukono as nyuko_no -- 入庫番号
from tmp30_dm_vinhis_nyukodetail
left outer join stg_hanbaitentenpomaster
on tmp30_dm_vinhis_nyukodetail.nyukohanbaitencd = stg_hanbaitentenpomaster.hanbaitencd
and tmp30_dm_vinhis_nyukodetail.uketsuketenpocd = stg_hanbaitentenpomaster.tenpocd
