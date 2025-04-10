{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
}}

with stg_saimudenpyo_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        yzdtid::varchar(20) as yzdtid, -- ユーザデータID
        ksno::varchar(14) as ksno, -- 決裁NO
        ksnooibn::varchar(2) as ksnooibn, -- 決裁NO追番
        dnpsyri::varchar(1) as dnpsyri, -- 伝票種類
        dnpsyrimsy::varchar(16) as dnpsyrimsy, -- 伝票種類名称
        synjtkb::varchar(1) as synjtkb, -- 承認状態区分
        rnksttskb::varchar(1) as rnksttskb, -- 連携ステータス区分
        dnstybrnksttskb::varchar(1) as dnstybrnksttskb, -- 電子帳簿連携ステータス区分
        khysykd::varchar(10) as khysykd, -- 起票者コード
        khysymi::varchar(20) as khysymi, -- 起票者名
        khybsykd::varchar(5) as khybsykd, -- 起票部署コード
        khybsymsy::varchar(32) as khybsymsy, -- 起票部署名称
        khysynisnbng::varchar(15) as khysynisnbng, -- 起票者内線番号
        khysygisnbng::varchar(15) as khysygisnbng, -- 起票者外線番号
        khysymradr::varchar(150) as khysymradr, -- 起票者メールアドレス
        khysykmnt::varchar(200) as khysykmnt, -- 起票者コメント
        khyb::varchar(8) as khyb, -- 起票日
        kssykb::varchar(6) as kssykb, -- 決裁者区分
        kssykd::varchar(10) as kssykd, -- 決裁者コード
        kssymi::varchar(20) as kssymi, -- 決裁者名
        kssybsykd::varchar(5) as kssybsykd, -- 決裁者部署コード
        kssybsymsy::varchar(32) as kssybsymsy, -- 決裁者部署名称
        kssymradr::varchar(150) as kssymradr, -- 決裁者メールアドレス
        synntjfn::varchar(8) as synntjfn, -- 承認日時分
        syhnkb::varchar(4) as syhnkb, -- 商品区分
        syhnkbmsy::varchar(80) as syhnkbmsy, -- 商品区分名称
        hnmkbtutwkfrg::varchar(1) as hnmkbtutwkfrg, -- 品目別内訳フラグ
        mbrumkb::varchar(1) as mbrumkb, -- 前払有無区分
        tkymsy::varchar(80) as tkymsy, -- 摘要名称
        kjbi::varchar(8) as kjbi, -- 計上日
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        trhkskmi::varchar(80) as trhkskmi, -- 取引先名
        trhkskknkd::varchar(3) as trhkskknkd, -- 取引先国コード
        kzijgysybngkb::varchar(1) as kzijgysybngkb, -- 課税事業者番号区分
        skysyno::varchar(15) as skysyno, -- 請求書NO
        inbisno::varchar(15) as inbisno, -- インボイスNO
        tknbi::varchar(8) as tknbi, -- 通関日
        mbrno::varchar(15) as mbrno, -- 前払NO
        srytbi::varchar(8) as srytbi, -- 支払予定日
        srtukkd::varchar(3) as srtukkd, -- 支払通貨コード
        srtukmsy::varchar(3) as srtukmsy, -- 支払通貨名称
        kzkb::varchar(4) as kzkb, -- 口座区分
        gnkkdkm4kt::varchar(4) as gnkkdkm4kt, -- 銀行コード(上4桁)
        gnkmi::varchar(120) as gnkmi, -- 銀行名
        gnkstnkd::varchar(3) as gnkstnkd, -- 銀行支店コード
        gnkstnmsy::varchar(80) as gnkstnmsy, -- 銀行支店名称
        kzno::varchar(38) as kzno, -- 口座NO
        kzmg::varchar(120) as kzmg, -- 口座名義
        gikksfrg::varchar(1) as gikksfrg, -- 外貨規制フラグ
        sknmktkkd::varchar(3) as sknmktkkd, -- 送金目的コード
        sknmktkmsy::varchar(140) as sknmktkmsy, -- 送金目的名称
        ttntukkd::varchar(3) as ttntukkd, -- 建値通貨コード
        ttntukmsy::varchar(3) as ttntukmsy, -- 建値通貨名称
        ttntukkngk::varchar(16) as ttntukkngk, -- 建値通貨金額
        tkyrt::varchar(10) as tkyrt, -- 適用レート
        msj::varchar(50) as msj, -- メッセージ
        nykntsryftnkb::varchar(1) as nykntsryftnkb, -- 入金手数料負担区分
        nykntsryftnkbmsy::varchar(20) as nykntsryftnkbmsy, -- 入金手数料負担区分名称
        srkngk::varchar(16) as srkngk, -- 支払金額
        kbikkrkd::varchar(2) as kbikkrkd, -- 購買係コード
        jskkjnngt::varchar(6) as jskkjnngt, -- 実績計上年月
        suhtsykb::varchar(1) as suhtsykb, -- 下請法対象区分
        suhtsykbmsy::varchar(8) as suhtsykbmsy, -- 下請法対象区分名称
        zsywifrg::varchar(1) as zsywifrg, -- 贈収賄フラグ
        trhksktntskd::varchar(3) as trhksktntskd, -- 取引先担当者コード
        trhksktntsbsymi::varchar(50) as trhksktntsbsymi, -- 取引先担当者部署名
        trhksktntsmi::varchar(30) as trhksktntsmi, -- 取引先担当者名
        trhkskmradr::varchar(150) as trhkskmradr, -- 取引先メールアドレス
        tsytntskd::varchar(3) as tsytntskd, -- 当社担当者コード
        tsytntskisymi::varchar(30) as tsytntskisymi, -- 当社担当者会社名
        tsytntsbsymi::varchar(50) as tsytntsbsymi, -- 当社担当者部署名
        tsytntsmi::varchar(30) as tsytntsmi, -- 当社担当者名
        tsytntsmradr::varchar(150) as tsytntsmradr, -- 当社担当者メールアドレス
        mtksno::varchar(14) as mtksno, -- 元決裁NO
        mtksnooibn::varchar(2) as mtksnooibn, -- 元決裁NO追番
        sysiry::varchar(40) as sysiry, -- 修正理由
        hnmknyrykkns::varchar(6) as hnmknyrykkns, -- 品目入力件数
        srhh::varchar(1) as srhh, -- 支払方法
        mtsrtukkd::varchar(3) as mtsrtukkd, -- (元)支払通貨コード
        mtsrbi::varchar(8) as mtsrbi, -- (元)支払日
        dnpryykb::varchar(1) as dnpryykb, -- 伝票流用区分
        dnphznjtkb::varchar(1) as dnphznjtkb, -- 伝票保存状態区分
        hnmkitrnhznjtkb::varchar(1) as hnmkitrnhznjtkb, -- 品目一覧保存状態区分
        ndbi::varchar(8) as ndbi, -- ND日
        cdbi::varchar(8) as cdbi, -- CD日
        syknskkd::varchar(10) as syknskkd, -- 出金先コード
        syknskmi::varchar(80) as syknskmi, -- 出金先名
        knsnrt::varchar(10) as knsnrt, -- 換算レート
        mmr::varchar(40) as mmr, -- メモ欄
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta008')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_saimudenpyo_meisai_judgev
