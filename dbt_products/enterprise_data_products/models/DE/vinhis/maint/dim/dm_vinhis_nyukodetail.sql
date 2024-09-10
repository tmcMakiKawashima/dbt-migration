with
    tmp30 as (
        select * from {{ ref('tmp30_dm_vinhis_nyukodetail') }}
    ),
    hanbaitentenpomaster as (
        select
            hanbaitencd, -- 入庫販売店コード
            tenpocd, -- 受付店舗コード
            tenponame -- 受付店舗名称
        from {{ ref('stg_hanbaitentenpomaster') }} -- 販売店店舗マスタ
    )
select
    tmp30.syadai_kt as syadai_kt, -- 車台型式
    tmp30.frmno as frm_no, -- フレームNo
    tmp30.nyukohanbaitencd as nyuko_dlrcd, -- 入庫販売店コード
    tmp30.hanbaitenname as nyuko_dlrcd_name, -- 入庫販売店名称
    tmp30.uketsuketenpocd as uketuke_tenpo_cd, -- 受付店舗コード
    hanbaitentenpomaster.tenponame as uketuke_tenpo_name, -- 受付店舗名称
    tmp30.nyukokbn as nyuko_kbn, -- 入庫区分
    tmp30.value as nyuko_kbn_name, -- 入庫区分名
    tmp30.nyukoyoteiymd as nyuko_plan_date, -- 入庫予定日
    tmp30.uketsukeymd as uketuke_date, -- 受付日
    tmp30.soukoukm as soukou_km, -- 走行km
    tmp30.jutyuno as jutyu_no, -- 受注No
    tmp30.seisanymd as payment_date, -- 精算年月日
    tmp30.nyukono as nyuko_no -- 入庫番号
from tmp30
left outer join hanbaitentenpomaster
  on tmp30.nyukohanbaitencd = hanbaitentenpomaster.hanbaitencd
 and tmp30.uketsuketenpocd = hanbaitentenpomaster.tenpocd
