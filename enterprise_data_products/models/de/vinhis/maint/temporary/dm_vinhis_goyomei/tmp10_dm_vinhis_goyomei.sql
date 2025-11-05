with
    nyukodetail as (
        select * from {{ ref('dm_vinhis_nyukodetail') }} -- VIN x 入庫明細
    ),
    goyoumei as (
        select
            nyukono, -- 入庫番号
            meisaino, -- 明細行番号
            hosyokbn as hosyo_umu, -- 保証有無
            t1w, -- T1Wコード
            goyomeisansyocd -- ご用命参照コード
        from {{ ref('stg_goyoumei') }} -- ご用命
        where delflg = '0'
    )
select
    nyukodetail.*,
    goyoumei.* exclude (nyukono)
from nyukodetail
left outer join goyoumei
 on nyukodetail.nyuko_no = goyoumei.nyukono