{{
    config (
        materialized = 'incremental',
        unique_key = ['frmno', 'hkata', 'frmkbn', 'shamei', 'sno'],
        incremental_strategy = 'merge'
    )
}}

with stg_haisyagenshi_valid as (
    select
        datid, -- ﾃﾞｰﾀID
        yy, -- 年
        mm, -- 月
        dd, -- 日
        hh, -- 時
        ff, -- 分
        ss, -- 秒
        mtdate, -- mtdate
        uyy, -- 売上日年
        umm, -- 売上日月
        udd, -- 売上日日
        uriageymd, -- uriageymd
        odt, -- ｵｰﾀﾞｰﾀｲﾌﾟ
        shamei, -- 車名
        sno, -- 仕様書NO
        hkata, -- 販売型式
        katacd, -- 型式ｺｰﾄﾞ
        gaicd, -- 外鈑
        ucd, -- 内張
        tire, -- ﾀｲﾔ
        joption, -- 受注ｵﾌﾟｼｮﾝ
        hoption, -- 標準ｵﾌﾟｼｮﾝ
        frmkbn, -- ﾌﾚｰﾑ区分
        frmno, -- ﾌﾚｰﾑNO
        egno, -- ｴﾝｼﾞﾝNO
        smkcd, -- 仕向先
        zaikosk, -- 在庫先
        yusosk, -- 輸送先
        odnooshamei, -- ｵｰﾀﾞｰNO.車名
        odnodfsc, -- ｵｰﾀﾞｰNO.DFSC
        odnoomm, -- ｵｰﾀﾞｰNO.月
        odnoojj, -- ｵｰﾀﾞｰNO.旬
        odnoserno, -- ｵｰﾀﾞｰNO.ｼﾘｱﾙNO
        orderno, -- orderno
        ukecd, -- 受渡ｺｰﾄﾞ
        tiremk, -- ﾀｲﾔﾒｰｶｰ
        chusi, -- 引当中止
        tokcd, -- 特殊ｺｰﾄﾞ
        skkbn, -- 新旧区分
        tehkbn, -- 手配区分
        sketai, -- 処理形態
        kteki, -- 完検適否
        haikymdyy, -- 配車回答日.年
        haikymdmm, -- 配車回答日.月
        haikymddd, -- 配車回答日.日
        haisyakaitoymd, -- haisyakaitoymd
        syuymdyy, -- 終検日.年
        syuymdmm, -- 終検日.月
        syuymddd, -- 終検日.日
        syukenymd, -- syukenymd
        hikymdyy, -- 引取日.年
        hikymdmm, -- 引取日.月
        hikymddd, -- 引取日.日
        hikitoriymd, -- hikitoriymd
        haiymdyy, -- 配車日.年
        haiymdmm, -- 配車日.月
        haiymddd, -- 配車日.日
        haisyaymd, -- haisyaymd
        dlrname, -- 販売店名称
        shimukename, -- 仕向先名
        address, -- 住所
        bukbn, -- 部区分
        tecs, -- TECS
        kasomaker, -- 架装ﾒｰｶｰ
        kukcd, -- 完成受渡し
        wax, -- WAXｻｲﾝ
        seikyu, -- 請求先
        wrap, -- ﾗｯﾌﾟ実績
        ldts -- B層取込日時
    from {{ ref('stg_haisyagenshi') }}
    where sketai in ('20','30')

    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_haisyagenshi_valid