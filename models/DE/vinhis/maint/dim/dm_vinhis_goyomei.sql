with
    tmp20_dm_vinhis_goyomei as (
        select * from {{ ref("tmp20_dm_vinhis_goyomei") }}
    ),
    stg_codekubun as (
        select
            key, -- 調子伺い結果コード
            value -- 調子伺い結果コード名称
        from {{ ref("stg_codekubun") }} -- コード区分マスタ
        where codekbnid = '037'
    )
select
    tmp20_dm_vinhis_goyomei.syadai_kt, -- 車台型式
    tmp20_dm_vinhis_goyomei.frm_no, -- フレームNo
    tmp20_dm_vinhis_goyomei.nyuko_dlrcd, -- 入庫販売店コード
    tmp20_dm_vinhis_goyomei.nyuko_dlrcd_name, -- 入庫販売店名称
    tmp20_dm_vinhis_goyomei.uketuke_tenpo_cd, -- 受付店舗コード
    tmp20_dm_vinhis_goyomei.uketuke_tenpo_name, -- 受付店舗名称
    tmp20_dm_vinhis_goyomei.nyuko_kbn, -- 入庫区分
    tmp20_dm_vinhis_goyomei.nyuko_kbn_name, -- 入庫区分名
    tmp20_dm_vinhis_goyomei.nyuko_plan_date, -- 入庫予定日
    tmp20_dm_vinhis_goyomei.uketuke_date, -- 受付日
    tmp20_dm_vinhis_goyomei.soukou_km, -- 走行km
    tmp20_dm_vinhis_goyomei.jutyu_no, -- 受注No
    tmp20_dm_vinhis_goyomei.payment_date, -- 精算年月日
    tmp20_dm_vinhis_goyomei.nyuko_no, -- 入庫番号
    tmp20_dm_vinhis_goyomei.meisaino as nyuko_detail_no, -- 明細行番号
    tmp20_dm_vinhis_goyomei.hosyo_umu as hosyo_umu, -- 保証有無
    tmp20_dm_vinhis_goyomei.t1w as t1w_cd, -- T1Wコード
    null as t1w_cd_name, -- T1Wコード名称
    tmp20_dm_vinhis_goyomei.goyomeisansyocd as goyomei_cd, -- ご用命参照コード
    null as goyomei_cd_name, -- ご用命参照コード名称
    tmp20_dm_vinhis_goyomei.sainyukoymd as sai_nyuko_date, -- 再入庫予定日
    tmp20_dm_vinhis_goyomei.tyoushiukagaikekkacd as choushi_kekka_cd, -- 調子伺い結果コード
    stg_codekubun.value as choushi_kekka_cd_name, -- 調子伺い結果コード名称
    tmp20_dm_vinhis_goyomei.genincd as genin_cd, -- 原因コード
    tmp20_dm_vinhis_goyomei.geninmeisyo as genin_cd_name, -- 原因名称
    tmp20_dm_vinhis_goyomei.hosyokbn as hosyo_kbn, -- 保証区分
    null as hosyo_kbn_name, -- 保証区分名称
    tmp20_dm_vinhis_goyomei.hosyoseikyusyono as hosyo_seikyusyo_no, -- 保証請求書No
    tmp20_dm_vinhis_goyomei.huguaisaigenumu as fuguai_saigen_umu -- 不具合再現有無
from tmp20_dm_vinhis_goyomei
left outer join stg_codekubun on tmp20_dm_vinhis_goyomei.tyoushiukagaikekkacd = stg_codekubun.key
