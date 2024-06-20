with
    dm_vinhis_nyukodetail as (
        select * from {{ ref("dm_vinhis_nyukodetail") }} -- VIN x 入庫明細
    ),
    stg_buhinreki as (
        select
            nyukono, -- 入庫番号
            meisaino, -- 明細行番号
            buhinsuryo, -- 部品数量
            hinban -- 品番コード
        from {{ ref("stg_buhinreki") }} -- 部品歴
        where delflg = '0'
    )
select
    dm_vinhis_nyukodetail.syadai_kt, -- 車台型式
    dm_vinhis_nyukodetail.frm_no, -- フレームNo
    dm_vinhis_nyukodetail.nyuko_dlrcd, -- 入庫販売店コード
    dm_vinhis_nyukodetail.nyuko_dlrcd_name, -- 入庫販売店名称
    dm_vinhis_nyukodetail.uketuke_tenpo_cd, -- 受付店舗コード
    dm_vinhis_nyukodetail.uketuke_tenpo_name, -- 受付店舗名称
    dm_vinhis_nyukodetail.nyuko_kbn, -- 入庫区分
    dm_vinhis_nyukodetail.nyuko_kbn_name, -- 入庫区分名
    dm_vinhis_nyukodetail.nyuko_plan_date, -- 入庫予定日
    dm_vinhis_nyukodetail.uketuke_date, -- 受付日
    dm_vinhis_nyukodetail.soukou_km, -- 走行km
    dm_vinhis_nyukodetail.jutyu_no, -- 受注No
    dm_vinhis_nyukodetail.payment_date, -- 精算年月日
    dm_vinhis_nyukodetail.nyuko_no, -- 入庫番号
    stg_buhinreki.meisaino, -- 明細行番号
    stg_buhinreki.hinban, -- 品番コード
    stg_buhinreki.buhinsuryo -- 部品数量
from dm_vinhis_nyukodetail
inner join stg_buhinreki on dm_vinhis_nyukodetail.nyuko_no = stg_buhinreki.nyukono
