with
    tmp20_dm_vinhis_nyukodetail as (
        select
            syadai_kt, -- 車台型式
            frm_no, -- フレームNo
            nyuko_dlrcd, -- 入庫販売店コード
            uketuke_tenpo_cd, -- 受付店舗コード
            nyuko_kbn, -- 入庫区分
            nyuko_kbn_name, -- 入庫区分名
            nyuko_plan_date, -- 入庫予定日
            uketuke_date, -- 受付日
            soukou_km, -- 走行km
            jutyu_no, -- 受注No
            payment_date, -- 精算年月日
            nyuko_no -- 入庫番号
        from {{ ref("tmp20_dm_vinhis_nyukodetail") }}
    ),
    stg_hanbaitenmaster as (
        select
            hanbaitencd, -- 入庫販売店コード
            hanbaitenname -- 入庫販売店名称
        from {{ ref("stg_hanbaitenmaster") }} -- 販売店マスタ
    ),
    tmp30_dm_vinhis_nyukodetail as (
        select
            tmp20_dm_vinhis_nyukodetail.syadai_kt, -- 車台型式
            tmp20_dm_vinhis_nyukodetail.frm_no, -- フレームNo
            tmp20_dm_vinhis_nyukodetail.nyuko_dlrcd, -- 入庫販売店コード
            stg_hanbaitenmaster.hanbaitenname as nyuko_dlrcd_name, -- 入庫販売店名称
            tmp20_dm_vinhis_nyukodetail.uketuke_tenpo_cd, -- 受付店舗コード
            tmp20_dm_vinhis_nyukodetail.nyuko_kbn, -- 入庫区分
            tmp20_dm_vinhis_nyukodetail.nyuko_kbn_name, -- 入庫区分名
            tmp20_dm_vinhis_nyukodetail.nyuko_plan_date, -- 入庫予定日
            tmp20_dm_vinhis_nyukodetail.uketuke_date, -- 受付日
            tmp20_dm_vinhis_nyukodetail.soukou_km, -- 走行km
            tmp20_dm_vinhis_nyukodetail.jutyu_no, -- 受注No
            tmp20_dm_vinhis_nyukodetail.payment_date, -- 精算年月日
            tmp20_dm_vinhis_nyukodetail.nyuko_no -- 入庫番号
        from tmp20_dm_vinhis_nyukodetail
        left outer join stg_hanbaitenmaster on tmp20_dm_vinhis_nyukodetail.nyuko_dlrcd = stg_hanbaitenmaster.hanbaitencd
    )
select * from tmp30_dm_vinhis_nyukodetail
