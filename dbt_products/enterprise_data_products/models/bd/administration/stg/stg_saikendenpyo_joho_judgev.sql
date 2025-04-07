{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
}}

with stg_saikendenpyo_joho_judgev as (
  select
        snsid::varchar(21) as snsid, -- 申請ID
        yzdtid::varchar(20) as yzdtid, -- ユーザデータID
        dnpsyri::varchar(1) as dnpsyri, -- 伝票種類
        dnpsyrimsy::varchar(16) as dnpsyrimsy, -- 伝票種類名称
        ksno::varchar(14) as ksno, -- 決裁NO
        ksnooibn::varchar(2) as ksnooibn, -- 決裁NO追番
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
        gikksfrg::varchar(1) as gikksfrg, -- 外貨規制フラグ
        trhkskbtutwkfrg::varchar(1) as trhkskbtutwkfrg, -- 取引先別内訳フラグ
        hnmkbtutwkfrg::varchar(1) as hnmkbtutwkfrg, -- 品目別内訳フラグ
        muknobtutwkfrg::varchar(1) as muknobtutwkfrg, -- 前受NO別内訳フラグ
        skykkrkd::varchar(2) as skykkrkd, -- 支給係コード
        kjbi::varchar(8) as kjbi, -- 計上日
        jskkjnngt::varchar(6) as jskkjnngt, -- 実績計上年月
        mukatukkb::varchar(1) as mukatukkb, -- 前受後受区分
        mukno::varchar(9) as mukno, -- 前受NO
        tkymsy::varchar(80) as tkymsy, -- 摘要名称
        trhksgk::varchar(16) as trhksgk, -- 取引総額
        mtksno::varchar(14) as mtksno, -- 元決裁NO
        mtksnooibn::varchar(2) as mtksnooibn, -- 元決裁NO追番
        sysiry::varchar(40) as sysiry, -- 修正理由
        trhksknyrykkns::varchar(5) as trhksknyrykkns, -- 取引先入力件数
        hnmknyrykkns::varchar(6) as hnmknyrykkns, -- 品目入力件数
        muknyrykkns::varchar(5) as muknyrykkns, -- 前受入力件数
        nyknhh::varchar(1) as nyknhh, -- 入金方法
        dnpryykb::varchar(1) as dnpryykb, -- 伝票流用区分
        dnphznjtkb::varchar(1) as dnphznjtkb, -- 伝票保存状態区分
        hnmkitrnhznjtkb::varchar(1) as hnmkitrnhznjtkb, -- 品目一覧保存状態区分
        trhkskitrnhznjtkb::varchar(1) as trhkskitrnhznjtkb, -- 取引先一覧保存状態区分
        mukitrnhznjtkb::varchar(1) as mukitrnhznjtkb, -- 前受一覧保存状態区分
        ndbi::varchar(8) as ndbi, -- ND日
        cdbi::varchar(8) as cdbi, -- CD日
        mmr::varchar(40) as mmr, -- メモ欄
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp, -- タイムスタンプ
        from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta005')}}
      {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta005')}})
      {% endif %}
)
select *  from stg_saikendenpyo_joho_judgev
