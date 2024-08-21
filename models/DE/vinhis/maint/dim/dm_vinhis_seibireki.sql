with
    tmp10_dm_vinhis_seibireki as (
        select * from {{ ref('tmp10_dm_vinhis_seibireki') }}
    ),
    stg_seibimeisyomaster as (
        select
            seibi_cd, -- 整備コード
            seibi_name -- 整備名称
        from {{ ref('stg_seibimeisyomaster') }}-- 整備名称情報マスタ
    )
select
    tmp10_dm_vinhis_seibireki.syadai_kt, -- 車台型式
    tmp10_dm_vinhis_seibireki.frm_no, -- フレーム連番
    tmp10_dm_vinhis_seibireki.nyuko_dlrcd, -- 入庫販売店コード
    tmp10_dm_vinhis_seibireki.nyuko_dlrcd_name, -- 入庫販売店名称
    tmp10_dm_vinhis_seibireki.uketuke_tenpo_cd, -- 受付店舗コード
    tmp10_dm_vinhis_seibireki.uketuke_tenpo_name, -- 受付店舗名称
    tmp10_dm_vinhis_seibireki.nyuko_kbn, -- 入庫区分
    tmp10_dm_vinhis_seibireki.nyuko_kbn_name, -- 入庫区分名
    tmp10_dm_vinhis_seibireki.nyuko_plan_date, -- 入庫予定日
    tmp10_dm_vinhis_seibireki.uketuke_date, -- 受付日
    tmp10_dm_vinhis_seibireki.soukou_km, -- 走行km
    tmp10_dm_vinhis_seibireki.jyutyu_no, -- 受注NO
    tmp10_dm_vinhis_seibireki.payment_date, -- 精算年月日
    tmp10_dm_vinhis_seibireki.nyuko_no, -- 入庫番号
    tmp10_dm_vinhis_seibireki.nyuko_detail_no, -- 明細行番号
    tmp10_dm_vinhis_seibireki.seibi_cd, -- 整備コード
    stg_seibimeisyomaster.seibi_name as seibi_cd_name -- 整備コード名称
from tmp10_dm_vinhis_seibireki
left outer join stg_seibimeisyomaster on tmp10_dm_vinhis_seibireki.seibi_cd = stg_seibimeisyomaster.seibi_cd
