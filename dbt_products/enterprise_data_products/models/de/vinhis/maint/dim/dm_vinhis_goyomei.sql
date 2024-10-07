with
    tmp20 as (
        select * from {{ ref('tmp20_dm_vinhis_goyomei') }}
    ),
    codekubun as (
        select
            key, -- 調子伺い結果コード
            value -- 調子伺い結果コード名称
        from {{ ref('stg_codekubun') }} -- コード区分マスタ
        where codekbnid = '037'
    )
select
    tmp20.syadai_kt, -- 車台型式
    tmp20.frm_no, -- フレームNo
    tmp20.nyuko_dlrcd, -- 入庫販売店コード
    tmp20.nyuko_dlrcd_name, -- 入庫販売店名称
    tmp20.uketuke_tenpo_cd, -- 受付店舗コード
    tmp20.uketuke_tenpo_name, -- 受付店舗名称
    tmp20.nyuko_kbn, -- 入庫区分
    tmp20.nyuko_kbn_name, -- 入庫区分名
    tmp20.nyuko_plan_date, -- 入庫予定日
    tmp20.uketuke_date, -- 受付日
    tmp20.soukou_km, -- 走行km
    tmp20.jutyu_no as jyutyu_no, -- 受注No
    tmp20.payment_date, -- 精算年月日
    tmp20.nyuko_no, -- 入庫番号
    tmp20.meisaino as nyuko_detail_no, -- 明細行番号
    tmp20.hosyo_umu as hosyo_umu, -- 保証有無
    tmp20.t1w as t1w_cd, -- T1Wコード
    null as t1w_cd_name, -- T1Wコード名称
    tmp20.goyomeisansyocd as goyomei_cd, -- ご用命参照コード
    null as goyomei_cd_name, -- ご用命参照コード名称
    tmp20.sainyukoymd as sai_nyuko_date, -- 再入庫予定日
    tmp20.tyoushiukagaikekkacd as choushi_kekka_cd, -- 調子伺い結果コード
    codekubun.value as choushi_kekka_cd_name, -- 調子伺い結果コード名称
    tmp20.genincd as genin_cd, -- 原因コード
    tmp20.geninmeisyo as genin_cd_name, -- 原因名称
    tmp20.hosyokbn as hosyo_kbn, -- 保証区分
    null as hosyo_kbn_name, -- 保証区分名称
    tmp20.hosyoseikyusyono as hosyo_seikyusyo_no, -- 保証請求書No
    tmp20.huguaisaigenumu as fuguai_saigen_umu -- 不具合再現有無
from tmp20
left outer join codekubun on tmp20.tyoushiukagaikekkacd = codekubun.key