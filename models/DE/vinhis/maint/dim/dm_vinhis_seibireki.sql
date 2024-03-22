with
    tmp10_dm_vinhis_seibireki as (
        select
            syadai_kt, -- 車台型式
            frm_no, -- フレームNo
            nyuko_dlrcd, -- 入庫販売店コード
            nyuko_dlrcd_name, -- 入庫販売店名称
            uketuke_tenpo_cd, -- 受付店舗コード
            uketuke_tenpo_name, -- 受付店舗名称
            nyuko_kbn, -- 入庫区分
            nyuko_kbn_name, -- 入庫区分名
            nyuko_plan_date, -- 入庫予定日
            uketuke_date, -- 受付日
            soukou_km, -- 走行km
            jutyu_no, -- 受注No
            payment_date, -- 精算年月日
            nyuko_no, -- 入庫番号
            nyuko_detail_no, -- 明細行番号
            seibi_cd -- 整備コード
        from {{ ref("tmp10_dm_vinhis_seibireki") }}
    ),
    m_seibi_name as (
        select
            seibi_cd, -- 整備コード
            seibi_name -- 整備コード名称
        from {{ source('customerservice_db_public', 'm_seibi_name') }} -- 整備名称情報マスタ
    ),
    dm_vinhis_seibireki as (
        select
            tmp10_dm_vinhis_seibireki.syadai_kt, -- 車台型式
            tmp10_dm_vinhis_seibireki.frm_no, -- フレームNo
            tmp10_dm_vinhis_seibireki.nyuko_dlrcd, -- 入庫販売店コード
            tmp10_dm_vinhis_seibireki.nyuko_dlrcd_name, -- 入庫販売店名称
            tmp10_dm_vinhis_seibireki.uketuke_tenpo_cd, -- 受付店舗コード
            tmp10_dm_vinhis_seibireki.uketuke_tenpo_name, -- 受付店舗名称
            tmp10_dm_vinhis_seibireki.nyuko_kbn, -- 入庫区分
            tmp10_dm_vinhis_seibireki.nyuko_kbn_name, -- 入庫区分名
            tmp10_dm_vinhis_seibireki.nyuko_plan_date, -- 入庫予定日
            tmp10_dm_vinhis_seibireki.uketuke_date, -- 受付日
            tmp10_dm_vinhis_seibireki.soukou_km, -- 走行km
            tmp10_dm_vinhis_seibireki.jutyu_no, -- 受注No
            tmp10_dm_vinhis_seibireki.payment_date, -- 精算年月日
            tmp10_dm_vinhis_seibireki.nyuko_no, -- 入庫番号
            tmp10_dm_vinhis_seibireki.nyuko_detail_no, -- 明細行番号
            tmp10_dm_vinhis_seibireki.seibi_cd, -- 整備コード
            m_seibi_name.seibi_name as seibi_cd_name -- 整備コード名称
        from tmp10_dm_vinhis_seibireki
        left outer join m_seibi_name on tmp10_dm_vinhis_seibireki.seibi_cd = m_seibi_name.seibi_cd
    )
select * from dm_vinhis_seibireki
