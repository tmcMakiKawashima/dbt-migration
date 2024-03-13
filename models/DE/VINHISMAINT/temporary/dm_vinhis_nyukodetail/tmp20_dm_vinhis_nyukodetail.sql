with
    tmp10_dm_vinhis_nyukodetail as (
        select
            syadai_kt, -- 車台型式
            frm_no, -- フレームNo
            nyuko_dlrcd, -- 入庫販売店コード
            uketuke_tenpo_cd, -- 受付店舗コード
            nyuko_kbn, -- 入庫区分
            nyuko_plan_date, -- 入庫予定日
            uketuke_date, -- 受付日
            soukou_km, -- 走行km
            jutyu_no, -- 受注No
            payment_date, -- 精算年月日
            nyuko_no -- 入庫番号
        from {{ ref("tmp10_dm_vinhis_nyukodetail") }}
    ),
    stg_codekubun as (
        select
            key, -- 入庫区分
            value -- 入庫区分名
        from {{ ref("stg_codekubun") }} -- コード区分マスタ
        where codekbnid = '028'
    ),
    tmp20_dm_vinhis_nyukodetail as (
        select
            tmp10_dm_vinhis_nyukodetail.syadai_kt, -- 車台型式
            tmp10_dm_vinhis_nyukodetail.frm_no, -- フレームNo
            tmp10_dm_vinhis_nyukodetail.nyuko_dlrcd, -- 入庫販売店コード
            tmp10_dm_vinhis_nyukodetail.uketuke_tenpo_cd, -- 受付店舗コード
            tmp10_dm_vinhis_nyukodetail.nyuko_kbn, -- 入庫区分
            stg_codekubun.value as nyuko_kbn_name, -- 入庫区分名
            tmp10_dm_vinhis_nyukodetail.nyuko_plan_date, -- 入庫予定日
            tmp10_dm_vinhis_nyukodetail.uketuke_date, -- 受付日
            tmp10_dm_vinhis_nyukodetail.soukou_km, -- 走行km
            tmp10_dm_vinhis_nyukodetail.jutyu_no, -- 受注No
            tmp10_dm_vinhis_nyukodetail.payment_date, -- 精算年月日
            tmp10_dm_vinhis_nyukodetail.nyuko_no -- 入庫番号
        from tmp10_dm_vinhis_nyukodetail
        left outer join stg_codekubun on tmp10_dm_vinhis_nyukodetail.nyuko_kbn = stg_codekubun.key
    )
select * from tmp20_dm_vinhis_nyukodetail
