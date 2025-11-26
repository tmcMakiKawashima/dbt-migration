{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
}}

with stg_saikentorihikisaki_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        msino::varchar(5) as msino, -- 明細NO
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        trhkskmi::varchar(80) as trhkskmi, -- 取引先名
        trhkskknkd::varchar(3) as trhkskknkd, -- 取引先国コード
        nyknskkd::varchar(10) as nyknskkd, -- 入金先コード
        nyknskmi::varchar(80) as nyknskmi, -- 入金先名
        smkskkd::varchar(10) as smkskkd, -- 仕向先コード
        smkskmi::varchar(80) as smkskmi, -- 仕向先名
        ttntukkd::varchar(3) as ttntukkd, -- 建値通貨コード
        ttntukmsy::varchar(3) as ttntukmsy, -- 建値通貨名称
        knsnrt::varchar(10) as knsnrt, -- 換算レート
        tkyrt::varchar(10) as tkyrt, -- 適用レート
        enknsngk::varchar(16) as enknsngk, -- 円換算額
        kisyjknkd::varchar(2) as kisyjknkd, -- 回収条件コード
        kisyjknmsy::varchar(8) as kisyjknmsy, -- 回収条件名称
        kknnyknhh::varchar(1) as kknnyknhh, -- 国内入金方法
        gnsnzkjytumfrg::varchar(1) as gnsnzkjytumfrg, -- 源泉税控除予定有無フラグ
        gnsnzkjgk::varchar(16) as gnsnzkjgk, -- 源泉税控除額
        sntzekjumfrg::varchar(1) as sntzekjumfrg, -- その他税控除有無フラグ
        sntzknkjgk::varchar(16) as sntzknkjgk, -- その他税金控除額
        nyknkngk::varchar(16) as nyknkngk, -- 入金金額
        nyknytbi::varchar(8) as nyknytbi, -- 入金予定日
        nyknkzkb::varchar(1) as nyknkzkb, -- 入金口座区分
        nyknkzkbmsy::varchar(8) as nyknkzkbmsy, -- 入金口座区分名称
        snykzkd::varchar(6) as snykzkd, -- 専用口座コード
        gnkkd1::varchar(4) as gnkkd1, -- 銀行コード1
        gnkmi1::varchar(120) as gnkmi1, -- 銀行名1
        gnkstnkd1::varchar(3) as gnkstnkd1, -- 銀行支店コード1
        gnkstnmi1::varchar(80) as gnkstnmi1, -- 銀行支店名1
        yknsybtkb1::varchar(1) as yknsybtkb1, -- 預金種別区分1
        yknsybtkbmsy1::varchar(8) as yknsybtkbmsy1, -- 預金種別区分名称1
        kzbng1::varchar(7) as kzbng1, -- 口座番号1
        gnkkd2::varchar(4) as gnkkd2, -- 銀行コード2
        gnkmi2::varchar(120) as gnkmi2, -- 銀行名2
        gnkstnkd2::varchar(3) as gnkstnkd2, -- 銀行支店コード2
        gnkstnmi2::varchar(80) as gnkstnmi2, -- 銀行支店名2
        yknsybtkb2::varchar(1) as yknsybtkb2, -- 預金種別区分2
        yknsybtkbmsy2::varchar(8) as yknsybtkbmsy2, -- 預金種別区分名称2
        kzbng2::varchar(7) as kzbng2, -- 口座番号2
        trhkniy::varchar(80) as trhkniy, -- 取引内容
        hntigk::varchar(16) as hntigk, -- 本体額
        syhzgk::varchar(16) as syhzgk, -- 消費税額
        skykngk::varchar(16) as skykngk, -- 請求金額
        skysysksumfrg::varchar(1) as skysysksumfrg, -- 請求書作成有無フラグ
        skysyno::varchar(15) as skysyno, -- 請求書NO
        tnpsyrumfrg::varchar(1) as tnpsyrumfrg, -- 添付書類有無フラグ
        tnpsyrumfrgmsy::varchar(4) as tnpsyrumfrgmsy, -- 添付書類有無フラグ名称
        tyhywebhisnkb::varchar(1) as tyhywebhisnkb, -- 帳票WEB配信区分
        sysitky::varchar(40) as sysitky, -- 詳細摘要
        skyskybnbng::varchar(7) as skyskybnbng, -- 請求先郵便番号
        skyskjsy::varchar(60) as skyskjsy, -- 請求先住所
        skysktntbsymi::varchar(32) as skysktntbsymi, -- 請求先担当部署名
        skysktntsmi::varchar(20) as skysktntsmi, -- 請求先担当者名
        skyskmradr::varchar(150) as skyskmradr, -- 請求先メールアドレス
        nykntukkd::varchar(3) as nykntukkd, -- 入金通貨コード
        nykntukmsy::varchar(3) as nykntukmsy, -- 入金通貨名称
        drftno::varchar(10) as drftno, -- ドラフトNO
        lcno::varchar(32) as lcno, -- L/CNO
        inbisno::varchar(15) as inbisno, -- インボイスNO
        skysytitrkb::varchar(1) as skysytitrkb, -- 請求書タイトル区分
        skysytitrmsy::varchar(10) as skysytitrmsy, -- 請求書タイトル名称
        description::varchar(100) as description, -- DESCRIPTION
        tkmsjkd1::varchar(3) as tkmsjkd1, -- 定型メッセージコード1
        remarksbk1::varchar(100) as remarksbk1, -- Remarks(備考)1
        tkmsjkd2::varchar(3) as tkmsjkd2, -- 定型メッセージコード2
        remarksbk2::varchar(100) as remarksbk2, -- Remarks(備考)2
        tkmsjkd3::varchar(3) as tkmsjkd3, -- 定型メッセージコード3
        remarksbk3::varchar(100) as remarksbk3, -- Remarks(備考)3
        gnsnzrt::varchar(6) as gnsnzrt, -- 源泉税率
        jsykd::varchar(3) as jsykd, -- 住所コード
        tsytntskd::varchar(3) as tsytntskd, -- 当社担当者コード
        tsytntskisymi::varchar(30) as tsytntskisymi, -- 当社担当者会社名
        tsytntsbsymi::varchar(100) as tsytntsbsymi, -- 当社担当者部署名
        tsytntsmi::varchar(60) as tsytntsmi, -- 当社担当者名
        tsytntsmradr::varchar(150) as tsytntsmradr, -- 当社担当者メールアドレス
        tsysinsykd::varchar(3) as tsysinsykd, -- 当社サイン者コード
        tsysinsykisymi::varchar(30) as tsysinsykisymi, -- 当社サイン者会社名
        tsysinsybsymi::varchar(50) as tsysinsybsymi, -- 当社サイン者部署名
        tsysinsyyksykmi::varchar(30) as tsysinsyyksykmi, -- 当社サイン者役職名
        tsysinsysmi::varchar(30) as tsysinsysmi, -- 当社サイン者氏名
        mtnykntukkd::varchar(3) as mtnykntukkd, -- (元)入金通貨コード
        mtnyknbi::varchar(8) as mtnyknbi, -- (元)入金日
        hznjtkb::varchar(1) as hznjtkb, -- 保存状態区分
        mmr::varchar(40) as mmr, -- メモ欄
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta007')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}

)
select * from stg_saikentorihikisaki_meisai_judgev