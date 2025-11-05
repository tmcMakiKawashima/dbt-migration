{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_jcard_meisai_judgev as (
    select
        jkdrydtno::varchar(16) as jkdrydtno, -- Jカード利用データNO
        jgyinkd::varchar(10) as jgyinkd, -- 従業員コード
        jgyinmi::varchar(20) as jgyinmi, -- 従業員名
        jgyinmradr::varchar(256) as jgyinmradr, -- 従業員メールアドレス
        syzkbsykd::varchar(10) as syzkbsykd, -- 所属部署コード
        syzkbsymi::varchar(40) as syzkbsymi, -- 所属部署名
        ryjhsusnsykd1::varchar(10) as ryjhsusnsykd1, -- 利用情報送信者コード1
        ryjhsusnsymradr1::varchar(256) as ryjhsusnsymradr1, -- 利用情報送信者メールアドレス1
        ryjhsusnsykd2::varchar(10) as ryjhsusnsykd2, -- 利用情報送信者コード2
        ryjhsusnsymradr2::varchar(256) as ryjhsusnsymradr2, -- 利用情報送信者メールアドレス2
        ryjhsusnsykd3::varchar(10) as ryjhsusnsykd3, -- 利用情報送信者コード3
        ryjhsusnsymradr3::varchar(256) as ryjhsusnsymradr3, -- 利用情報送信者メールアドレス3
        ryjhsusnsykd4::varchar(10) as ryjhsusnsykd4, -- 利用情報送信者コード4
        ryjhsusnsymradr4::varchar(256) as ryjhsusnsymradr4, -- 利用情報送信者メールアドレス4
        khybsykd::varchar(10) as khybsykd, -- 起票部署コード
        kdkiinbng::varchar(16) as kdkiinbng, -- カード会員番号
        rybi::varchar(8) as rybi, -- 利用日
        rykngk::varchar(16) as rykngk, -- 利用金額
        kmtnmi::varchar(40) as kmtnmi, -- 加盟店名
        snsid::varchar(21) as snsid, -- 申請ID
        ksno::varchar(14) as ksno, -- 決裁NO
        khysykd::varchar(10) as khysykd, -- 起票者コード
        khysymi::varchar(20) as khysymi, -- 起票者名
        kjbi::varchar(8) as kjbi, -- 計上日
        jkdhkkmjtkb::varchar(1) as jkdhkkmjtkb, -- Jカード引込状態区分
        jkdhkkmjtkbmi::varchar(40) as jkdhkkmjtkbmi, -- Jカード引込状態区分名
        mrsusnzmfrg::varchar(1) as mrsusnzmfrg, -- メール送信済フラグ
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta022')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_jcard_meisai_judgev
