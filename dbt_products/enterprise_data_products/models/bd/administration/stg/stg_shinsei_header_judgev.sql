{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_shinsei_header_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        yzdtid::varchar(20) as yzdtid, -- ユーザデータID
        snskb::varchar(6) as snskb, -- 申請区分
        snskbmi::varchar(40) as snskbmi, -- 申請区分名
        rthntkb::varchar(2) as rthntkb, -- ルート判定区分
        ksno::varchar(14) as ksno, -- 決裁NO
        ksnooibn::varchar(3) as ksnooibn, -- 決裁NO追番
        snsno::varchar(12) as snsno, -- 申請NO
        snsnooibn::varchar(3) as snsnooibn, -- 申請NO追番
        dnpkb::varchar(1) as dnpkb, -- 伝票区分
        dnpkbmi::varchar(40) as dnpkbmi, -- 伝票区分名
        dnpsysikb::varchar(1) as dnpsysikb, -- 伝票詳細区分
        dnpsysikbmi::varchar(40) as dnpsysikbmi, -- 伝票詳細区分名
        kisykd::varchar(4) as kisykd, -- 会社コード
        kisymi::varchar(80) as kisymi, -- 会社名
        khysykd::varchar(10) as khysykd, -- 起票者コード
        khysymi::varchar(20) as khysymi, -- 起票者名
        khybsykd::varchar(10) as khybsykd, -- 起票部署コード
        khybsymi::varchar(40) as khybsymi, -- 起票部署名
        khysymradr::varchar(256) as khysymradr, -- 起票者メールアドレス
        khysynisnbng::varchar(15) as khysynisnbng, -- 起票者内線番号
        khysygisnbng::varchar(15) as khysygisnbng, -- 起票者外線番号
        khysykmnt::varchar(200) as khysykmnt, -- 起票者コメント
        d1kssykssykd::varchar(10) as d1kssykssykd, -- 第一決裁者_決裁者コード
        d1kssykssymi::varchar(20) as d1kssykssymi, -- 第一決裁者_決裁者名
        d1kssyksbsykd::varchar(10) as d1kssyksbsykd, -- 第一決裁者_決裁部署コード
        d1kssyksbsymi::varchar(40) as d1kssyksbsymi, -- 第一決裁者_決裁部署名
        d1kssykssymradr::varchar(256) as d1kssykssymradr, -- 第一決裁者_決裁者メールアドレス
        d1kssysynbi::varchar(8) as d1kssysynbi, -- 第一決裁者_承認日
        d1kssysykmnt::varchar(200) as d1kssysykmnt, -- 第一決裁者_承認時コメント
        d2kssykssykd::varchar(10) as d2kssykssykd, -- 第二決裁者_決裁者コード
        d2kssykssymi::varchar(20) as d2kssykssymi, -- 第二決裁者_決裁者名
        d2kssyksbsykd::varchar(10) as d2kssyksbsykd, -- 第二決裁者_決裁部署コード
        d2kssyksbsymi::varchar(40) as d2kssyksbsymi, -- 第二決裁者_決裁部署名
        d2kssykssymradr::varchar(256) as d2kssykssymradr, -- 第二決裁者_決裁者メールアドレス
        d2kssysynbi::varchar(8) as d2kssysynbi, -- 第二決裁者_承認日
        d2kssysykmnt::varchar(200) as d2kssysykmnt, -- 第二決裁者_承認時コメント
        zmknsykssykd::varchar(10) as zmknsykssykd, -- 税務確認者_決裁者コード
        zmknsykssymi::varchar(20) as zmknsykssymi, -- 税務確認者_決裁者名
        zmknsyksbsykd::varchar(10) as zmknsyksbsykd, -- 税務確認者_決裁部署コード
        zmknsyksbsymi::varchar(40) as zmknsyksbsymi, -- 税務確認者_決裁部署名
        zmknsykssymradr::varchar(256) as zmknsykssymradr, -- 税務確認者_決裁者メールアドレス
        zmknsysynbi::varchar(8) as zmknsysynbi, -- 税務確認者_承認日
        zmknsysykmnt::varchar(200) as zmknsysykmnt, -- 税務確認者_承認時コメント
        sisykssykd::varchar(10) as sisykssykd, -- 最終決裁者コード
        sisykssymi::varchar(20) as sisykssymi, -- 最終決裁者名
        sisykssysynntj::varchar(8) as sisykssysynntj, -- 最終決裁者承認日時
        synjtkb::varchar(1) as synjtkb, -- 承認状態区分
        synjtkbmi::varchar(40) as synjtkbmi, -- 承認状態区分名
        khyb::varchar(8) as khyb, -- 起票日
        kskgn::varchar(12) as kskgn, -- 決裁期限
        snsymtksno::varchar(14) as snsymtksno, -- 参照元決裁NO
        snsymttkid::varchar(10) as snsymttkid, -- 参照元定型ID
        trksmtsnsid::varchar(21) as trksmtsnsid, -- 取消元申請ID
        trksmtksno::varchar(14) as trksmtksno, -- 取消元決裁NO
        tkid::varchar(10) as tkid, -- 定型ID
        tktrkniy::varchar(24) as tktrkniy, -- 定型登録内容
        tktrkbsykd::varchar(10) as tktrkbsykd, -- 定型登録部署コード
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta014') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_shinsei_header_judgev
