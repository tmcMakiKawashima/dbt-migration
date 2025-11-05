{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_torihiki_tekiyo_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        utwkkb::varchar(1) as utwkkb, -- 内訳区分
        utwkkbmi::varchar(40) as utwkkbmi, -- 内訳区分名
        trhksksptfrg::varchar(1) as trhksksptfrg, -- 取引先スポットフラグ
        kjbi::varchar(8) as kjbi, -- 計上日
        tkymsy::varchar(80) as tkymsy, -- 摘要名称
        zsywifrg::varchar(1) as zsywifrg, -- 贈収賄フラグ
        ksijknkb::varchar(2) as ksijknkb, -- 決済条件区分
        ksijknkbmi::varchar(40) as ksijknkbmi, -- 決済条件区分名
        mbrno::varchar(15) as mbrno, -- 前払NO
        mukno::varchar(9) as mukno, -- 前受NO
        syknhhkd::varchar(1) as syknhhkd, -- 出金方法コード
        syknhhmi::varchar(40) as syknhhmi, -- 出金方法名
        nfsymis::varchar(4) as nfsymis, -- 納付書枚数
        srjknkb::varchar(1) as srjknkb, -- 支払条件区分
        srjknkbmi::varchar(40) as srjknkbmi, -- 支払条件区分名
        tktbiry::varchar(40) as tktbiry, -- 特定日理由
        srytbi::varchar(8) as srytbi, -- 支払予定日
        nyknytbi::varchar(8) as nyknytbi, -- 入金予定日
        gikksfrg::varchar(1) as gikksfrg, -- 外貨規制フラグ
        ttntukkd::varchar(3) as ttntukkd, -- 建値通貨コード
        ttntukmi::varchar(80) as ttntukmi, -- 建値通貨名
        srtukkd::varchar(3) as srtukkd, -- 支払通貨コード
        srtukmi::varchar(80) as srtukmi, -- 支払通貨名
        nykntukkd::varchar(3) as nykntukkd, -- 入金通貨コード
        nykntukmi::varchar(80) as nykntukmi, -- 入金通貨名
        rttni::varchar(3) as rttni, -- レート単位
        knsnrt::varchar(10) as knsnrt, -- 換算レート
        tkyrt::varchar(10) as tkyrt, -- 適用レート
        sknmktkkd::varchar(3) as sknmktkkd, -- 送金目的コード
        sknmktkmi::varchar(70) as sknmktkmi, -- 送金目的名
        nyknmktkkd::varchar(3) as nyknmktkkd, -- 入金目的コード
        nyknmktkmi::varchar(70) as nyknmktkmi, -- 入金目的名
        msj::varchar(50) as msj, -- メッセージ
        nykntsryftnkb::varchar(1) as nykntsryftnkb, -- 入金手数料負担区分
        nykntsryftnkbmi::varchar(40) as nykntsryftnkbmi, -- 入金手数料負担区分名
        knsybi::varchar(8) as knsybi, -- 検収日
        knsysyjgyinkd::varchar(10) as knsysyjgyinkd, -- 検収者従業員コード
        knsysyjgyinmi::varchar(20) as knsysyjgyinmi, -- 検収者従業員名
        knsysybsykd::varchar(10) as knsysybsykd, -- 検収者部署コード
        knsysybsymi::varchar(40) as knsysybsymi, -- 検収者部署名
        tnkmbrkb::varchar(1) as tnkmbrkb, -- 短期前払区分
        tnkmbrkbmi::varchar(40) as tnkmbrkbmi, -- 短期前払区分名
        suhtsytrhkkb::varchar(1) as suhtsytrhkkb, -- 下請法対象取引区分
        suhtsytrhkkbmi::varchar(40) as suhtsytrhkkbmi, -- 下請法対象取引区分名
        nyknkzkb::varchar(1) as nyknkzkb, -- 入金口座区分
        nyknkzkbmi::varchar(40) as nyknkzkbmi, -- 入金口座区分名
        snykzkd::varchar(7) as snykzkd, -- 専用口座コード
        snykzgnkkd1::varchar(4) as snykzgnkkd1, -- 専用口座銀行コード1
        snykzgnkmi1::varchar(80) as snykzgnkmi1, -- 専用口座銀行名1
        snykzstnkd1::varchar(3) as snykzstnkd1, -- 専用口座支店コード1
        snykzstnmi1::varchar(80) as snykzstnmi1, -- 専用口座支店名1
        snykzyknsymk1::varchar(1) as snykzyknsymk1, -- 専用口座預金種目1
        snykzyknsymkmi1::varchar(40) as snykzyknsymkmi1, -- 専用口座預金種目名1
        snykzno1::varchar(7) as snykzno1, -- 専用口座NO1
        snykzgnkkd2::varchar(4) as snykzgnkkd2, -- 専用口座銀行コード2
        snykzgnkmi2::varchar(80) as snykzgnkmi2, -- 専用口座銀行名2
        snykzstnkd2::varchar(3) as snykzstnkd2, -- 専用口座支店コード2
        snykzstnmi2::varchar(80) as snykzstnmi2, -- 専用口座支店名2
        snykzyknsymk2::varchar(1) as snykzyknsymk2, -- 専用口座預金種目2
        snykzyknsymkmi2::varchar(40) as snykzyknsymkmi2, -- 専用口座預金種目名2
        snykzno2::varchar(7) as snykzno2, -- 専用口座NO2
        snykztrhkniy::varchar(80) as snykztrhkniy, -- 専用口座取引内容
        jgyinkd::varchar(10) as jgyinkd, -- 従業員コード
        jgyinmi::varchar(20) as jgyinmi, -- 従業員名
        bsykd::varchar(10) as bsykd, -- 部署コード
        bsymi::varchar(40) as bsymi, -- 部署名
        rybi::varchar(8) as rybi, -- 利用日
        rykngk::varchar(16) as rykngk, -- 利用金額
        jkdkhytykfrg::varchar(1) as jkdkhytykfrg, -- Jカード起票チェックフラグ
        jkdrydtno::varchar(16) as jkdrydtno, -- Jカード利用データNO
        jkdbng::varchar(16) as jkdbng, -- Jカード番号
        kfrtyjnrymsino::varchar(18) as kfrtyjnrymsino, -- 口振超人利用明細NO
        rngno::varchar(5) as rngno, -- 稟議NO
        sysiry::varchar(40) as sysiry, -- 修正理由
        trksry::varchar(80) as trksry, -- 取消理由
        mtksno::varchar(14) as mtksno, -- 元決裁NO
        ysnumkb::varchar(1) as ysnumkb, -- 予算有無区分
        ysnumkbmi::varchar(40) as ysnumkbmi, -- 予算有無区分名
        ysnkomkkd::varchar(10) as ysnkomkkd, -- 予算項目コード
        ysnkomkmi::varchar(40) as ysnkomkmi, -- 予算項目名
        zmjhhkkmfrg::varchar(1) as zmjhhkkmfrg, -- 税務情報引込フラグ
        kjkb::varchar(1) as kjkb, -- 計上区分
        kjkbmi::varchar(40) as kjkbmi, -- 計上区分名
        smksksptfrg::varchar(1) as smksksptfrg, -- 仕向先スポットフラグ
        krgkhntigkttn::varchar(16) as krgkhntigkttn, -- 借方合計本体額_建値
        ksgkhntigkttn::varchar(16) as ksgkhntigkttn, -- 貸方合計本体額_建値
        krgksyhzgkttn::varchar(16) as krgksyhzgkttn, -- 借方合計消費税額_建値
        ksgksyhzgkttn::varchar(16) as ksgksyhzgkttn, -- 貸方合計消費税額_建値
        krgkzkmgkttn::varchar(16) as krgkzkmgkttn, -- 借方合計税込額_建値
        ksgkzkmgkttn::varchar(16) as ksgkzkmgkttn, -- 貸方合計税込額_建値
        krgkhntigkenk::varchar(16) as krgkhntigkenk, -- 借方合計本体額_円貨
        ksgkhntigkenk::varchar(16) as ksgkhntigkenk, -- 貸方合計本体額_円貨
        krgksyhzgkenk::varchar(16) as krgksyhzgkenk, -- 借方合計消費税額_円貨
        ksgksyhzgkenk::varchar(16) as ksgksyhzgkenk, -- 貸方合計消費税額_円貨
        krgkzkmgkenk::varchar(16) as krgkzkmgkenk, -- 借方合計税込額_円貨
        ksgkzkmgkenk::varchar(16) as ksgkzkmgkenk, -- 貸方合計税込額_円貨
        gkihntigkenk::varchar(16) as gkihntigkenk, -- 合計本体額_円貨
        gkisyhzgkenk::varchar(16) as gkisyhzgkenk, -- 合計消費税額_円貨
        gkizkmgkenk::varchar(16) as gkizkmgkenk, -- 合計税込額_円貨
        trkzmfrg::varchar(1) as trkzmfrg, -- 登録済フラグ
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta015') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_torihiki_tekiyo_judgev
