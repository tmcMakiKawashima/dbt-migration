{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_zeimu_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        trhkmsino::varchar(5) as trhkmsino, -- 取引明細NO
        zmmsino::varchar(4) as zmmsino, -- 税務明細NO
        kskghntrykb::varchar(2) as kskghntrykb, -- 交際会議_判定理由区分
        kskghntrykbmi::varchar(40) as kskghntrykbmi, -- 交際会議_判定理由区分名
        kskgniy::varchar(40) as kskgniy, -- 交際会議_内容
        kskgbsy::varchar(50) as kskgbsy, -- 交際会議_場所
        kskgmygks::varchar(6) as kskgmygks, -- 交際会議_土産個数
        kskgbk::varchar(40) as kskgbk, -- 交際会議_備考
        kskgkkhsbi::varchar(8) as kskgkkhsbi, -- 交際会議_効果発生日
        kskgsnsid::varchar(21) as kskgsnsid, -- 交際会議_申請ID
        kskgsnsno::varchar(12) as kskgsnsno, -- 交際会議_申請NO
        kskgtsysnknz::varchar(6) as kskgtsysnknz, -- 交際会議_当社参加人数
        kskgtsyftntsynz::varchar(6) as kskgtsyftntsynz, -- 交際会議_当社負担当社人数
        kskgtsytnts::varchar(30) as kskgtsytnts, -- 交際会議_当社担当者
        kskgsnpsnknz::varchar(6) as kskgsnpsnknz, -- 交際会議_先方参加人数
        kskgtsyftnsnpnz::varchar(6) as kskgtsyftnsnpnz, -- 交際会議_当社負担先方人数
        kskgaitskkisymi::varchar(80) as kskgaitskkisymi, -- 交際会議_相手先会社名
        kskgaitsksmi::varchar(50) as kskgaitsksmi, -- 交際会議_相手先氏名
        kskgkminngihkb::varchar(1) as kskgkminngihkb, -- 交際会議_公務員の該非区分
        kskgkminngihkbmi::varchar(40) as kskgkminngihkbmi, -- 交際会議_公務員の該非区分名
        kskgtsytnknk::varchar(40) as kskgtsytnknk, -- 交際会議_当社との関係
        mbrniy::varchar(100) as mbrniy, -- 前払_内容
        mbrnhnkskkb::varchar(1) as mbrnhnkskkb, -- 前払_納品形式区分
        mbrnhnkskkbmi::varchar(40) as mbrnhnkskkbmi, -- 前払_納品形式区分名
        mbriktnhnbi::varchar(8) as mbriktnhnbi, -- 前払_一括_納品日
        mbriktnhnbigtitkniy::varchar(30) as mbriktnhnbigtitkniy, -- 前払_一括_納品日具体的内容
        mbriktkkhsbi::varchar(8) as mbriktkkhsbi, -- 前払_一括_効果発生日
        mbriktkkhsbigtitkniy::varchar(30) as mbriktkkhsbigtitkniy, -- 前払_一括_効果発生日具体的内容
        mbrkzktkksbi::varchar(8) as mbrkzktkksbi, -- 前払_継続定期_開始日
        mbrkzktksrybi::varchar(8) as mbrkzktksrybi, -- 前払_継続定期_終了日
        mbrkzktkksbisrybiniy::varchar(30) as mbrkzktkksbisrybiniy, -- 前払_継続定期_開始日終了日内容
        mbrzikknysry::varchar(6) as mbrzikknysry, -- 前払_在庫_購入数量
        mbrzikziksry::varchar(6) as mbrzikziksry, -- 前払_在庫_在庫数量
        mbrziksyjkyksry::varchar(6) as mbrziksyjkyksry, -- 前払_在庫_使用_除却数量
        mbrziktnkenk::varchar(16) as mbrziktnkenk, -- 前払_在庫_単価_円貨
        mbrzikzndkenk::varchar(16) as mbrzikzndkenk, -- 前払_在庫_残高_円貨
        krnbtky::varchar(80) as krnbtky, -- 繰延_摘要
        krnbkrnbsyri::varchar(1) as krnbkrnbsyri, -- 繰延_繰延種類
        krnbsykyknns::varchar(4) as krnbsykyknns, -- 繰延_償却年数
        krnbsyksnngp::varchar(8) as krnbsyksnngp, -- 繰延_使用開始年月日
        krnbsry::varchar(6) as krnbsry, -- 繰延_数量
        ktirsssnkd::varchar(8) as ktirsssnkd, -- 固定リース_資産コード
        ktirssyzkkd::varchar(10) as ktirssyzkkd, -- 固定リース_所属コード
        ktirssyksnngt::varchar(6) as ktirssyksnngt, -- 固定リース_使用開始年月
        ktirskjknrbsykd::varchar(1) as ktirskjknrbsykd, -- 固定リース_工場管理部署コード
        ktirsknrbng::varchar(11) as ktirsknrbng, -- 固定リース_管理番号
        ktirsrnbn::varchar(4) as ktirsrnbn, -- 固定リース_連番
        ktirssytkkgk::varchar(12) as ktirssytkkgk, -- 固定リース_取得価額
        ktirstybkgk::varchar(12) as ktirstybkgk, -- 固定リース_帳簿価額
        ktirsttmnsksry::varchar(10) as ktirsttmnsksry, -- 固定リース_土地面積/数量
        rskykksbi::varchar(8) as rskykksbi, -- リース_契約開始日
        rskyksrybi::varchar(8) as rskyksrybi, -- リース_契約終了日
        ukiroenrksynkd::varchar(3) as ukiroenrksynkd, -- 受入応援_ロケーションコード
        ukiroenrksynmi::varchar(40) as ukiroenrksynmi, -- 受入応援_ロケーション名
        ukiroennz::varchar(6) as ukiroennz, -- 受入応援_人数
        ukiroenkyysytk::varchar(16) as ukiroenkyysytk, -- 受入応援_給与所得
        ukiroenhkzsytk::varchar(16) as ukiroenhkzsytk, -- 受入応援_非課税所得
        ukiroengkikngk::varchar(16) as ukiroengkikngk, -- 受入応援_合計金額
        rsikrssnkd::varchar(8) as rsikrssnkd, -- リサイクル_資産コード
        rsikrksk::varchar(20) as rsikrksk, -- リサイクル_型式
        rsikrfrmno::varchar(17) as rsikrfrmno, -- リサイクル_フレームNO
        rsikrrsikrknbng::varchar(14) as rsikrrsikrknbng, -- リサイクル_リサイクル券番号
        rsikrsyzkkd::varchar(10) as rsikrsyzkkd, -- リサイクル_所属コード
        rsikrsyzkmi::varchar(40) as rsikrsyzkmi, -- リサイクル_所属名
        kngk::varchar(16) as kngk, -- 金額
        syhzkb::varchar(2) as syhzkb, -- 消費税区分
        syhzkbmi::varchar(100) as syhzkbmi, -- 消費税区分名
        zkmzbtkb::varchar(1) as zkmzbtkb, -- 税込税別区分
        zkmzbtkbmi::varchar(40) as zkmzbtkbmi, -- 税込税別区分名
        hntigkenk::varchar(16) as hntigkenk, -- 本体額_円貨
        syhzgkenk::varchar(16) as syhzgkenk, -- 消費税額_円貨
        zkmgkenk::varchar(16) as zkmgkenk, -- 税込額_円貨
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta020')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_zeimu_meisai_judgev
