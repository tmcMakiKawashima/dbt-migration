with
    tmp30_dm_vinhis_nyukodetail as (
        select
            syadai_kt, -- 車台型式
            frm_no, -- フレームNo
            nyuko_dlrcd, -- 入庫販売店コード
            nyuko_dlrcd_name, -- 入庫販売店名称
            uketuke_tenpo_cd, -- 受付店舗コード
            nyuko_kbn, -- 入庫区分
            nyuko_kbn_name, -- 入庫区分名
            nyuko_plan_date, -- 入庫予定日
            uketuke_date, -- 受付日
            soukou_km, -- 走行km
            jutyu_no, -- 受注No
            payment_date, -- 精算年月日
            nyuko_no -- 入庫番号
        from {{ ref("tmp30_dm_vinhis_nyukodetail") }}
    ),
    stg_hanbaitentenpomaster as (
        select
            hanbaitencd, -- 入庫販売店コード
            tenpocd, -- 受付店舗コード
            tenponame -- 受付店舗名称
        from {{ ref("stg_hanbaitentenpomaster") }} -- 販売店マスタ
    ),
    dm_vinhis_nyukodetail as (
        select
            tmp30_dm_vinhis_nyukodetail.syadai_kt, -- 車台型式
            tmp30_dm_vinhis_nyukodetail.frm_no, -- フレームNo
            tmp30_dm_vinhis_nyukodetail.nyuko_dlrcd, -- 入庫販売店コード
            tmp30_dm_vinhis_nyukodetail.nyuko_dlrcd_name, -- 入庫販売店名称
            tmp30_dm_vinhis_nyukodetail.uketuke_tenpo_cd, -- 受付店舗コード
            stg_hanbaitentenpomaster.tenpocd as uketuke_tenpo_name, -- 受付店舗名称
            tmp30_dm_vinhis_nyukodetail.nyuko_kbn, -- 入庫区分
            tmp30_dm_vinhis_nyukodetail.nyuko_kbn_name, -- 入庫区分名
            tmp30_dm_vinhis_nyukodetail.nyuko_plan_date, -- 入庫予定日
            tmp30_dm_vinhis_nyukodetail.uketuke_date, -- 受付日
            tmp30_dm_vinhis_nyukodetail.soukou_km, -- 走行km
            tmp30_dm_vinhis_nyukodetail.jutyu_no, -- 受注No
            tmp30_dm_vinhis_nyukodetail.payment_date, -- 精算年月日
            tmp30_dm_vinhis_nyukodetail.nyuko_no -- 入庫番号
        from tmp30_dm_vinhis_nyukodetail
        left outer join stg_hanbaitentenpomaster
        on tmp30_dm_vinhis_nyukodetail.nyuko_dlrcd = stg_hanbaitentenpomaster.hanbaitencd
        and tmp30_dm_vinhis_nyukodetail.uketuke_tenpo_cd = stg_hanbaitentenpomaster.tenpocd
    )
select * from dm_vinhis_nyukodetail
