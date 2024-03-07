with
    tmp10_dm_vinhis_goyomei as (
        select
            syadai_kt, -- 車台型式
            frm_no, -- フレームNo
            nyuko_dlrcd, -- 入庫販売店コード
            nyuko_dlrcd_name, -- 入庫販売店名称
            uketuke_tenpo_cd, -- 受付店舗コード
            uketuke_tenpo_name, -- 受付店舗名称
            nyuko_kbn, -- 入庫区分
            nyuko_kbn_name, -- 入庫区分名
            nyuko_plan_date, -- 入庫予定日
            uketuke_date, -- 受付日
            soukou_km, -- 走行km
            jutyu_no, -- 受注No
            payment_date, -- 精算年月日
            nyuko_no, -- 入庫番号
            nyuko_detail_no, -- 明細行番号
            t1w_cd, -- T1Wコード
            goyomei_cd -- ご用命参照コード
        from {{ ref("tmp10_dm_vinhis_goyomei") }}
    ),
    stg_goyoumeihosyo as (
        select
            nyukono, -- 入庫番号
            meisaino, -- 明細行番号
            sainyukoymd, -- 再入庫予定日
            tyoushiukagaikekkacd, -- 調子伺い結果コード
            genincd, -- 原因コード
            hosyokbn, -- 保証区分
            hosyoseikyusyono, -- 保証請求書No
            huguaisaigenumu, -- 不具合再現有無
            geninmeisyo -- 原因名称
        from {{ ref("stg_goyoumeihosyo") }} -- ご用命保証
        where delflg = '0'
    ),
    tmp20_dm_vinhis_goyomei as (
        select
            tmp10_dm_vinhis_goyomei.syadai_kt, -- 車台型式
            tmp10_dm_vinhis_goyomei.frm_no, -- フレームNo
            tmp10_dm_vinhis_goyomei.nyuko_dlrcd, -- 入庫販売店コード
            tmp10_dm_vinhis_goyomei.nyuko_dlrcd_name, -- 入庫販売店名称
            tmp10_dm_vinhis_goyomei.uketuke_tenpo_cd, -- 受付店舗コード
            tmp10_dm_vinhis_goyomei.uketuke_tenpo_name, -- 受付店舗名称
            tmp10_dm_vinhis_goyomei.nyuko_kbn, -- 入庫区分
            tmp10_dm_vinhis_goyomei.nyuko_kbn_name, -- 入庫区分名
            tmp10_dm_vinhis_goyomei.nyuko_plan_date, -- 入庫予定日
            tmp10_dm_vinhis_goyomei.uketuke_date, -- 受付日
            tmp10_dm_vinhis_goyomei.soukou_km, -- 走行km
            tmp10_dm_vinhis_goyomei.jutyu_no, -- 受注No
            tmp10_dm_vinhis_goyomei.payment_date, -- 精算年月日
            tmp10_dm_vinhis_goyomei.nyuko_no, -- 入庫番号
            tmp10_dm_vinhis_goyomei.nyuko_detail_no, -- 明細行番号
            tmp10_dm_vinhis_goyomei.t1w_cd, -- T1Wコード
            tmp10_dm_vinhis_goyomei.goyomei_cd, -- ご用命参照コード
            stg_goyoumeihosyo.sainyukoymd as sai_nyuko_date, -- 再入庫予定日
            stg_goyoumeihosyo.tyoushiukagaikekkacd as choushi_kekka_cd, -- 調子伺い結果コード
            stg_goyoumeihosyo.genincd as genin_cd, -- 原因コード
            stg_goyoumeihosyo.geninmeisyo as genin_cd_name, -- 原因名称
            stg_goyoumeihosyo.hosyokbn as hosyo_kbn, -- 保証区分
            stg_goyoumeihosyo.hosyoseikyusyono as hosyo_seikyusyo_no, -- 保証請求書No
            stg_goyoumeihosyo.huguaisaigenumu as fuguai_saigen_umu -- 不具合再現有無
        from tmp10_dm_vinhis_goyomei
        left outer join stg_goyoumeihosyo
        on tmp10_dm_vinhis_goyomei.nyuko_no = stg_goyoumeihosyo.nyukono
        and tmp10_dm_vinhis_goyomei.nyuko_detail_no = stg_goyoumeihosyo.meisaino
    )
select * from tmp20_dm_vinhis_goyomei
