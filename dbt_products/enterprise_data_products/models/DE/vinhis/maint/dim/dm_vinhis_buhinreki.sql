with
    tmp10_dm_vinhis_buhinreki as (
        select * from {{ ref('tmp10_dm_vinhis_buhinreki') }}
    ),
    stg_hinbanmeisyomaster as (
        select
            hinban, -- 品番
            hinmei -- 品名
        from {{ ref('stg_hinbanmeisyomaster') }} -- 品番情報マスタ
    )
select
    tmp10_dm_vinhis_buhinreki.syadai_kt, -- 車台型式
    tmp10_dm_vinhis_buhinreki.frm_no, -- フレーム連番
    tmp10_dm_vinhis_buhinreki.nyuko_dlrcd, -- 入庫販売店コード
    tmp10_dm_vinhis_buhinreki.nyuko_dlrcd_name, -- 入庫販売店名称
    tmp10_dm_vinhis_buhinreki.uketuke_tenpo_cd, -- 受付店舗コード
    tmp10_dm_vinhis_buhinreki.uketuke_tenpo_name, -- 受付店舗名称
    tmp10_dm_vinhis_buhinreki.nyuko_kbn, -- 入庫区分
    tmp10_dm_vinhis_buhinreki.nyuko_kbn_name, -- 入庫区分名
    tmp10_dm_vinhis_buhinreki.nyuko_plan_date, -- 入庫予定日
    tmp10_dm_vinhis_buhinreki.uketuke_date, -- 受付日
    tmp10_dm_vinhis_buhinreki.soukou_km, -- 走行km
    tmp10_dm_vinhis_buhinreki.jyutyu_no, -- 受注NO
    tmp10_dm_vinhis_buhinreki.payment_date, -- 精算年月日
    tmp10_dm_vinhis_buhinreki.nyuko_no, -- 入庫番号
    tmp10_dm_vinhis_buhinreki.nyuko_detail_no, -- 明細行番号
    tmp10_dm_vinhis_buhinreki.parts_cd, -- 品番コード
    stg_hinbanmeisyomaster.hinmei as parts_name, -- 品番名称
    tmp10_dm_vinhis_buhinreki.parts_amount -- 部品数量
from tmp10_dm_vinhis_buhinreki
left outer join stg_hinbanmeisyomaster on tmp10_dm_vinhis_buhinreki.parts_cd = stg_hinbanmeisyomaster.hinban
