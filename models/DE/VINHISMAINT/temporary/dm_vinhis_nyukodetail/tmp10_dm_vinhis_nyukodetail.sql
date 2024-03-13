with
    stg_nyukoreki as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレームNo
            nyukohanbaitencd, -- 入庫販売店コード
            uketsuketenpocd, -- 受付店舗コード
            nyukokbn, -- 入庫区分
            nyukoyoteiymd, -- 入庫予定日
            uketsukeymd, -- 受付日
            soukoukm, -- 走行km
            jutyuno, -- 受注No
            seisanymd -- 精算年月日
        from {{ ref("stg_nyukoreki") }} -- 入庫歴
        where delflg = '0'
    ),
    stg_nyukomeisaisakuin as (
        select
            nyukohanbaitencd, -- 入庫販売店コード
            jutyuno, -- 受注No
            seisanymd, -- 精算年月日
            nyukono -- 入庫番号
        from {{ ref("stg_nyukomeisaisakuin") }} -- 入庫明細索引
        where delflg = '0'
    ),
    tmp10_dm_vinhis_nyukodetail as (
        select
            stg_nyukoreki.syadai_kt as syadai_kt, -- 車台型式
            stg_nyukoreki.frmno as frm_no, -- フレームNo
            stg_nyukoreki.nyukohanbaitencd as nyuko_dlrcd, -- 入庫販売店コード
            stg_nyukoreki.uketsuketenpocd as uketuke_tenpo_cd, -- 受付店舗コード
            stg_nyukoreki.nyukokbn as nyuko_kbn, -- 入庫区分
            stg_nyukoreki.nyukoyoteiymd as nyuko_plan_date, -- 入庫予定日
            stg_nyukoreki.uketsukeymd as uketuke_date, -- 受付日
            stg_nyukoreki.soukoukm as soukou_km, -- 走行km
            stg_nyukoreki.jutyuno as jutyu_no, -- 受注No
            stg_nyukoreki.seisanymd as payment_date, -- 精算年月日
            stg_nyukomeisaisakuin.nyukono as nyuko_no -- 入庫番号
        from stg_nyukoreki
        inner join stg_nyukomeisaisakuin
        on stg_nyukoreki.nyukohanbaitencd = stg_nyukomeisaisakuin.nyukohanbaitencd
        and stg_nyukoreki.jutyuno = stg_nyukomeisaisakuin.jutyuno
        and stg_nyukoreki.seisanymd = stg_nyukomeisaisakuin.seisanymd
    )
select * from tmp10_dm_vinhis_nyukodetail
