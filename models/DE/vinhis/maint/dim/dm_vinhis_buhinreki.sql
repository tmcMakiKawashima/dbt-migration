with
    tmp10_dm_vinhis_buhinreki as (
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
            parts_cd, -- 品番コード
            parts_amount -- 部品数量
        from {{ ref("tmp10_dm_vinhis_buhinreki") }}
    ),
    m_parts_name as (
        select
            parts_cd, -- 品番コード
            parts_name -- 品番名称
        from {{ source('customerservice_db_public', 'm_parts_name') }} -- 整備名称情報マスタ
    ),
    dm_vinhis_buhinreki as (
        select
            tmp10_dm_vinhis_buhinreki.syadai_kt, -- 車台型式
            tmp10_dm_vinhis_buhinreki.frm_no, -- フレームNo
            tmp10_dm_vinhis_buhinreki.nyuko_dlrcd, -- 入庫販売店コード
            tmp10_dm_vinhis_buhinreki.nyuko_dlrcd_name, -- 入庫販売店名称
            tmp10_dm_vinhis_buhinreki.uketuke_tenpo_cd, -- 受付店舗コード
            tmp10_dm_vinhis_buhinreki.uketuke_tenpo_name, -- 受付店舗名称
            tmp10_dm_vinhis_buhinreki.nyuko_kbn, -- 入庫区分
            tmp10_dm_vinhis_buhinreki.nyuko_kbn_name, -- 入庫区分名
            tmp10_dm_vinhis_buhinreki.nyuko_plan_date, -- 入庫予定日
            tmp10_dm_vinhis_buhinreki.uketuke_date, -- 受付日
            tmp10_dm_vinhis_buhinreki.soukou_km, -- 走行km
            tmp10_dm_vinhis_buhinreki.jutyu_no, -- 受注No
            tmp10_dm_vinhis_buhinreki.payment_date, -- 精算年月日
            tmp10_dm_vinhis_buhinreki.nyuko_no, -- 入庫番号
            tmp10_dm_vinhis_buhinreki.nyuko_detail_no, -- 明細行番号
            tmp10_dm_vinhis_buhinreki.parts_cd, -- 品番コード
            m_parts_name.parts_name as parts_name, -- 品番名称
            tmp10_dm_vinhis_buhinreki.parts_amount -- 部品数量
        from tmp10_dm_vinhis_buhinreki
        left outer join m_parts_name on tmp10_dm_vinhis_buhinreki.parts_cd = m_parts_name.parts_cd
    )
select * from dm_vinhis_buhinreki
