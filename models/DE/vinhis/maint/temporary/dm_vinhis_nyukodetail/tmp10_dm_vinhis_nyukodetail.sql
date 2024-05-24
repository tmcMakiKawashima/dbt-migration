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
    )
select
    stg_nyukoreki.syadai_kt, -- 車台型式
    stg_nyukoreki.frmno, -- フレームNo
    stg_nyukoreki.nyukohanbaitencd, -- 入庫販売店コード
    stg_nyukoreki.uketsuketenpocd, -- 受付店舗コード
    stg_nyukoreki.nyukokbn, -- 入庫区分
    stg_nyukoreki.nyukoyoteiymd, -- 入庫予定日
    stg_nyukoreki.uketsukeymd, -- 受付日
    stg_nyukoreki.soukoukm, -- 走行km
    stg_nyukoreki.jutyuno, -- 受注No
    stg_nyukoreki.seisanymd, -- 精算年月日
    stg_nyukomeisaisakuin.nyukono -- 入庫番号
from stg_nyukoreki
inner join stg_nyukomeisaisakuin
on stg_nyukoreki.nyukohanbaitencd = stg_nyukomeisaisakuin.nyukohanbaitencd
and stg_nyukoreki.jutyuno = stg_nyukomeisaisakuin.jutyuno
and stg_nyukoreki.seisanymd = stg_nyukomeisaisakuin.seisanymd
