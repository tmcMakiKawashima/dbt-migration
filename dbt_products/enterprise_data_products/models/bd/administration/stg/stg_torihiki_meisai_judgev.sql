{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_torihiki_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        trhkmsino::varchar(5) as trhkmsino, -- 取引明細NO
        ttntukkd::varchar(3) as ttntukkd, -- 建値通貨コード
        ttntukmi::varchar(80) as ttntukmi, -- 建値通貨名
        frktrhksksptfrg::varchar(1) as frktrhksksptfrg, -- 振替取引先スポットフラグ
        skysyno::varchar(15) as skysyno, -- 請求書NO
        srinbisno::varchar(15) as srinbisno, -- 支払_インボイスNO
        nykninbisno::varchar(15) as nykninbisno, -- 入金_インボイスNO
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        spttrhkskkd::varchar(10) as spttrhkskkd, -- スポット取引先コード
        trhkskmi::varchar(80) as trhkskmi, -- 取引先名
        trhkskmikn::varchar(40) as trhkskmikn, -- 取引先名_カナ
        kzkb::varchar(4) as kzkb, -- 口座区分
        kjkb::varchar(1) as kjkb, -- 計上区分
        kjkbmi::varchar(40) as kjkbmi, -- 計上区分名
        smkskkd::varchar(10) as smkskkd, -- 仕向先コード
        sptsmkskkd::varchar(10) as sptsmkskkd, -- スポット仕向先コード
        smkskmi::varchar(80) as smkskmi, -- 仕向先名
        smkskknkd::varchar(3) as smkskknkd, -- 仕向先国コード
        smkskknmi::varchar(30) as smkskknmi, -- 仕向先国名
        srytbi::varchar(8) as srytbi, -- 支払予定日
        nyknytbi::varchar(8) as nyknytbi, -- 入金予定日
        nyknskkd::varchar(10) as nyknskkd, -- 入金先コード
        nyknskmi::varchar(40) as nyknskmi, -- 入金先名
        syknskkd::varchar(10) as syknskkd, -- 出金先コード
        syknskmi::varchar(40) as syknskmi, -- 出金先名
        komkkd::varchar(10) as komkkd, -- 項目コード
        komkmi::varchar(40) as komkmi, -- 項目名
        knsnrt::varchar(10) as knsnrt, -- 換算レート
        hmkkd::varchar(3) as hmkkd, -- 費目コード
        hmkmi::varchar(30) as hmkmi, -- 費目名
        rtkb::varchar(1) as rtkb, -- レート区分
        rtkbmi::varchar(40) as rtkbmi, -- レート区分名
        tkyrt::varchar(10) as tkyrt, -- 適用レート
        kisyjknkb::varchar(1) as kisyjknkb, -- 回収条件区分
        kisyjknkbmi::varchar(40) as kisyjknkbmi, -- 回収条件区分名
        grbrntngtsykb::varchar(1) as grbrntngtsykb, -- グローバルネッティング対象区分
        grbrntngtsykbmi::varchar(40) as grbrntngtsykbmi, -- グローバルネッティング対象区分名
        nyknhhkd::varchar(1) as nyknhhkd, -- 入金方法コード
        srkb::varchar(2) as srkb, -- 支払区分
        srkbmi::varchar(40) as srkbmi, -- 支払区分名
        gnsnzkjgk::varchar(16) as gnsnzkjgk, -- 源泉税控除額
        sntzknkjgk::varchar(16) as sntzknkjgk, -- その他税金控除額
        bsyutwkhyfrg::varchar(1) as bsyutwkhyfrg, -- 部署内訳票フラグ
        syhzkb::varchar(2) as syhzkb, -- 消費税区分
        syhzkbmi::varchar(100) as syhzkbmi, -- 消費税区分名
        hntigkttn::varchar(16) as hntigkttn, -- 本体額_建値
        syhzgkttn::varchar(16) as syhzgkttn, -- 消費税額_建値
        zkmgkttn::varchar(16) as zkmgkttn, -- 税込額_建値
        hntigkenk::varchar(16) as hntigkenk, -- 本体額_円貨
        syhzgkenk::varchar(16) as syhzgkenk, -- 消費税額_円貨
        zkmgkenk::varchar(16) as zkmgkenk, -- 税込額_円貨
        nyknkngkgik::varchar(16) as nyknkngkgik, -- 入金金額外貨
        skysyskskb::varchar(1) as skysyskskb, -- 請求書作成区分
        skysyskskbmi::varchar(40) as skysyskskbmi, -- 請求書作成区分名
        firrnkskkb::varchar(1) as firrnkskkb, -- ファイル連携先区分
        firrnkskkbmi::varchar(40) as firrnkskkbmi, -- ファイル連携先区分名
        skysytnpsyrkb::varchar(1) as skysytnpsyrkb, -- 請求書添付書類区分
        skysytnpsyrkbmi::varchar(40) as skysytnpsyrkbmi, -- 請求書添付書類区分名
        tisykkb::varchar(1) as tisykkb, -- 貸借区分
        tisykkbmi::varchar(40) as tisykkbmi, -- 貸借区分名
        kamkkd::varchar(10) as kamkkd, -- 科目コード
        kamkmi::varchar(40) as kamkmi, -- 科目名
        kskmknrno::varchar(14) as kskmknrno, -- 消込管理NO
        kzijgysybngumkb::varchar(1) as kzijgysybngumkb, -- 課税事業者番号有無区分
        kzijgysybngumkbmi::varchar(40) as kzijgysybngumkbmi, -- 課税事業者番号有無区分名
        trhkskknkd::varchar(3) as trhkskknkd, -- 取引先国コード
        trhkskknmi::varchar(30) as trhkskknmi, -- 取引先国名
        srgnkkkngnkkd::varchar(4) as srgnkkkngnkkd, -- 支払銀行国内_銀行コード
        srgnkkkngnkmi::varchar(80) as srgnkkkngnkmi, -- 支払銀行国内_銀行名
        srgnkkknstnkd::varchar(3) as srgnkkknstnkd, -- 支払銀行国内_支店コード
        srgnkkknstnmi::varchar(80) as srgnkkknstnmi, -- 支払銀行国内_支店名
        srgnkkknyknsybtkd::varchar(2) as srgnkkknyknsybtkd, -- 支払銀行国内_預金種別コード
        srgnkkknyknsybtmi::varchar(40) as srgnkkknyknsybtmi, -- 支払銀行国内_預金種別名
        uktrnkknkzno::varchar(38) as uktrnkknkzno, -- 受取人国内_口座NO
        uktrnkknkzmg::varchar(160) as uktrnkknkzmg, -- 受取人国内_口座名義
        srgnkkgisptgnkkd::varchar(15) as srgnkkgisptgnkkd, -- 支払銀行海外_スポット銀行コード
        srgnkkgignkmi::varchar(80) as srgnkkgignkmi, -- 支払銀行海外_銀行名
        srgnkkgistnmi::varchar(80) as srgnkkgistnmi, -- 支払銀行海外_支店名
        srgnkkgiswift::varchar(11) as srgnkkgiswift, -- 支払銀行海外_SWIFT
        srgnkkgiknbtgnkbng::varchar(15) as srgnkkgiknbtgnkbng, -- 支払銀行海外_国別銀行番号
        srgnkkgijsyknkd::varchar(3) as srgnkkgijsyknkd, -- 支払銀行海外_住所_国コード
        srgnkkgijsyknmi::varchar(30) as srgnkkgijsyknmi, -- 支払銀行海外_住所_国名
        srgnkkgijsysymitsmi::varchar(140) as srgnkkgijsysymitsmi, -- 支払銀行海外_住所_州名/都市名
        uktrnkgikznoibannd::varchar(38) as uktrnkgikznoibannd, -- 受取人海外_口座NO_IBAN等
        uktrnkgikzmg::varchar(160) as uktrnkgikzmg, -- 受取人海外_口座名義
        uktrnkgijsyknkd::varchar(3) as uktrnkgijsyknkd, -- 受取人海外_住所_国コード
        uktrnkgijsyknmi::varchar(30) as uktrnkgijsyknmi, -- 受取人海外_住所_国名
        uktrnkgijsysymitsmi::varchar(70) as uktrnkgijsysymitsmi, -- 受取人海外_住所_州名/都市名
        kiygnkkgisptgnkkd::varchar(15) as kiygnkkgisptgnkkd, -- 経由銀行海外_スポット銀行コード
        kiygnkkgignkmi::varchar(60) as kiygnkkgignkmi, -- 経由銀行海外_銀行名
        kiygnkkgistnmi::varchar(40) as kiygnkkgistnmi, -- 経由銀行海外_支店名
        kiygnkkgikzno::varchar(34) as kiygnkkgikzno, -- 経由銀行海外_口座NO
        kiygnkkgiswift::varchar(11) as kiygnkkgiswift, -- 経由銀行海外_SWIFT
        kiygnkkgijsyknkd::varchar(3) as kiygnkkgijsyknkd, -- 経由銀行海外_住所_国コード
        kiygnkkgijsyknmi::varchar(30) as kiygnkkgijsyknmi, -- 経由銀行海外_住所_国名
        khybsykd::varchar(10) as khybsykd, -- 起票部署コード
        skykkntrhkskybnbng::varchar(7) as skykkntrhkskybnbng, -- 請求国内_取引先郵便番号
        skykkntrhkskjsykd::varchar(3) as skykkntrhkskjsykd, -- 請求国内_取引先住所コード
        skykkntrhkskjsy::varchar(140) as skykkntrhkskjsy, -- 請求国内_取引先住所
        skykknsnpbsytnts::varchar(52) as skykknsnpbsytnts, -- 請求国内_先方部署担当者
        skykknsysitky::varchar(40) as skykknsysitky, -- 請求国内_詳細摘要
        skykgiskysytitrkb::varchar(1) as skykgiskysytitrkb, -- 請求海外_請求書タイトル区分
        skykgiskysytitrkbmi::varchar(40) as skykgiskysytitrkbmi, -- 請求海外_請求書タイトル区分名
        skykgidescription::varchar(100) as skykgidescription, -- 請求海外_DESCRIPTION
        skykgitkmsj1kd::varchar(3) as skykgitkmsj1kd, -- 請求海外_定型メッセージ1コード
        skykgitkmsj1mi::varchar(100) as skykgitkmsj1mi, -- 請求海外_定型メッセージ1名
        skykgitkmsj2kd::varchar(3) as skykgitkmsj2kd, -- 請求海外_定型メッセージ2コード
        skykgitkmsj2mi::varchar(100) as skykgitkmsj2mi, -- 請求海外_定型メッセージ2名
        skykgitkmsj3kd::varchar(3) as skykgitkmsj3kd, -- 請求海外_定型メッセージ3コード
        skykgitkmsj3mi::varchar(100) as skykgitkmsj3mi, -- 請求海外_定型メッセージ3名
        skykgignsnzrt::varchar(5) as skykgignsnzrt, -- 請求海外_源泉税率
        skykgisinkd::varchar(3) as skykgisinkd, -- 請求海外_サインコード
        skykgisinsybsymi::varchar(50) as skykgisinsybsymi, -- 請求海外_サイン者部署名
        skykgisinsyyksykmi::varchar(30) as skykgisinsyyksykmi, -- 請求海外_サイン者役職名
        skykgisinsymi::varchar(30) as skykgisinsymi, -- 請求海外_サイン者名
        trhksktntsjsykd::varchar(3) as trhksktntsjsykd, -- 取引先担当者_住所コード
        trhksktntsjsy::varchar(70) as trhksktntsjsy, -- 取引先担当者_住所
        trhksktntsbsymi::varchar(80) as trhksktntsbsymi, -- 取引先担当者_部署名
        trhksktntstntsmi::varchar(30) as trhksktntstntsmi, -- 取引先担当者_担当者名
        trhksktntsemail::varchar(256) as trhksktntsemail, -- 取引先担当者_E-MAIL
        tsytntstntskd::varchar(3) as tsytntstntskd, -- 当社担当者_担当者コード
        tsytntsbsymi::varchar(80) as tsytntsbsymi, -- 当社担当者_部署名
        tsytntstntsmi::varchar(30) as tsytntstntsmi, -- 当社担当者_担当者名
        tsytntsemail::varchar(256) as tsytntsemail, -- 当社担当者_E-MAIL
        gnsnzybnbng::varchar(7) as gnsnzybnbng, -- 源泉税_郵便番号
        gnsnzjsy::varchar(140) as gnsnzjsy, -- 源泉税_住所
        gnsnzjkymi::varchar(50) as gnsnzjkymi, -- 源泉税_住居名
        gnsnzsmi::varchar(50) as gnsnzsmi, -- 源泉税_氏名
        gnsnzjsykn::varchar(70) as gnsnzjsykn, -- 源泉税_住所_カナ
        gnsnzsmikn::varchar(50) as gnsnzsmikn, -- 源泉税_氏名_カナ
        gnsnzskykngkenk::varchar(16) as gnsnzskykngkenk, -- 源泉税_請求金額_円貨
        gnsnzutsyhzenk::varchar(16) as gnsnzutsyhzenk, -- 源泉税_内消費税_円貨
        gnsnzhntikngkkb::varchar(1) as gnsnzhntikngkkb, -- 源泉税_本体金額区分
        gnsnzhntikngkkbmi::varchar(40) as gnsnzhntikngkkbmi, -- 源泉税_本体金額区分名
        gnsnzniy::varchar(80) as gnsnzniy, -- 源泉税_内容
        gnsnzsgkttn::varchar(16) as gnsnzsgkttn, -- 源泉税_総額_建値
        gnsnzgnsnzgkttn::varchar(16) as gnsnzgnsnzgkttn, -- 源泉税_源泉税額_建値
        gnsnzsrgkttn::varchar(16) as gnsnzsrgkttn, -- 源泉税_支払額_建値
        gnsnzsgkenk::varchar(16) as gnsnzsgkenk, -- 源泉税_総額_円貨
        gnsnzgnsnzgkenk::varchar(16) as gnsnzgnsnzgkenk, -- 源泉税_源泉税額_円貨
        gnsnzsrgkenk::varchar(16) as gnsnzsrgkenk, -- 源泉税_支払額_円貨
        mmrn::varchar(40) as mmrn, -- メモ欄
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 5e3e0732196db9a77622fea22edeb3279d22a018
        uktrnkgijsytsmiyrme::varchar(70) as uktrnkgijsytsmiyrme, -- 受取人海外_住所_都市名より前
        uktrnkgijsytsmi::varchar(27) as uktrnkgijsytsmi, -- 受取人海外_住所_都市名
        uktrnkgijsytsmiyrat::varchar(30) as uktrnkgijsytsmiyrat, -- 受取人海外_住所_都市名より後
        srgnkkgijsytsmiyrme::varchar(70) as srgnkkgijsytsmiyrme, -- 支払銀行海外_住所_都市名より前
        srgnkkgijsytsmi::varchar(27) as srgnkkgijsytsmi, -- 支払銀行海外_住所_都市名
        srgnkkgijsytsmiyrat::varchar(30) as srgnkkgijsytsmiyrat, -- 支払銀行海外_住所_都市名より後
        tukykatrnksttskb::varchar(1) as tukykatrnksttskb, -- 当局宛連絡事項連携ステータス区分
        gnsntknkd::varchar(2) as gnsntknkd, -- 原産地_国コード
        fntmtknkd::varchar(2) as fntmtknkd, -- 船積地_国コード
        fntmttsmi::varchar(27) as fntmttsmi, -- 船積地_都市名
        smktknkd::varchar(2) as smktknkd, -- 仕向地_国コード
        smkttsmi::varchar(27) as smkttsmi, -- 仕向地_都市名
        prpskd::varchar(10) as prpskd, -- Purpose Code
<<<<<<< HEAD
=======
=======
>>>>>>> 768ad04709bf1b7708dede4e2d3f7a96ed3385c8
>>>>>>> 5e3e0732196db9a77622fea22edeb3279d22a018
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta016') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_torihiki_meisai_judgev
