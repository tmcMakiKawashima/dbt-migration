with
    nyukoreki as (
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
        from {{ ref('stg_nyukoreki') }} -- 入庫歴
        where delflg = '0'
    ),
    nyukomeisaisakuin as (
        select
            nyukohanbaitencd, -- 入庫販売店コード
            jutyuno, -- 受注No
            seisanymd, -- 精算年月日
            nyukono -- 入庫番号
        from {{ ref('stg_nyukomeisaisakuin') }} -- 入庫明細索引
        where delflg = '0'
    )
select
    nyukoreki.*,
    nyukomeisaisakuin.* exclude (nyukohanbaitencd, jutyuno, seisanymd)
from nyukoreki
inner join nyukomeisaisakuin
  on nyukoreki.nyukohanbaitencd = nyukomeisaisakuin.nyukohanbaitencd
 and nyukoreki.jutyuno = nyukomeisaisakuin.jutyuno
 and nyukoreki.seisanymd = nyukomeisaisakuin.seisanymd
