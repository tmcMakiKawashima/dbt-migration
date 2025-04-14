{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_torihikisaki_masta_judgev as (
    select
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        sskmi1::varchar(80) as sskmi1, -- 組織名１
        sskmi2::varchar(80) as sskmi2, -- 組織名２
        sskmi3::varchar(40) as sskmi3, -- 組織名３
        sskmi4::varchar(80) as sskmi4, -- 組織名４
        tdfkn::varchar(80) as tdfkn, -- 都道府県
        ybnbng::varchar(20) as ybnbng, -- 郵便番号
        sktysn::varchar(80) as sktysn, -- 市区町村
        kn::varchar(3) as kn, -- 国
        timzn::varchar(6) as timzn, -- タイムゾーン
        ssybk::varchar(10) as ssybk, -- 私書箱
        gng::varchar(1) as gng, -- 言語
        gibadrbng::varchar(20) as gibadrbng, -- 外部アドレス番号
        htkjti::varchar(2) as htkjti, -- 法的実体
        bptip::varchar(4) as bptip, -- BPタイプ
        trhksk::varchar(6) as trhksk, -- 取引先
        akibfrg::varchar(1) as akibfrg, -- アーカイブフラグ
        zs::varchar(15) as zs, -- 増資
        gnktsryftnkd::varchar(2) as gnktsryftnkd, -- 銀行手数料負担コード
        tkiskkd::varchar(10) as tkiskkd, -- 得意先コード
        tksktsiknj::varchar(10) as tksktsiknj, -- 得意先_統制勘定
        tkisksrhh::varchar(10) as tkisksrhh, -- 得意先_支払方法
        tkisktnts::varchar(30) as tkisktnts, -- 得意先担当者
        sntkkisykd::varchar(1) as sntkkisykd, -- 選択会社コード
        hnbissk::varchar(4) as hnbissk, -- 販売組織
        ryttynr::varchar(2) as ryttynr, -- 流通チャネル
        shnbmn::varchar(2) as shnbmn, -- 製品部門
        knjstgrp::varchar(2) as knjstgrp, -- 勘定設定グループ
        pr::varchar(2) as pr, -- PR
        srsktsiknj::varchar(10) as srsktsiknj, -- 仕入先_統制勘定
        srsksrhh::varchar(10) as srsksrhh, -- 仕入先_支払方法
        srsktnts::varchar(30) as srsktnts, -- 仕入先担当者
        kbissk::varchar(4) as kbissk, -- 購買組織
        kbigrp::varchar(3) as kbigrp, -- 購買グループ
        kbipf::varchar(2) as kbipf, -- 購買PF
        kknsrknkb::varchar(1) as kknsrknkb, -- 国内支払可能区分
        kknnyknknkb::varchar(1) as kknnyknknkb, -- 国内入金可能区分
        kgisrknkb::varchar(1) as kgisrknkb, -- 海外支払可能区分
        kginyknknkb::varchar(1) as kginyknknkb, -- 海外入金可能区分
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta010')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = ((select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta010')}}))
    {% endif %}
        
)
select * from stg_torihikisaki_masta_judgev
