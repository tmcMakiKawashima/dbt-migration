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
-- 洗い替え処理で常に最新断面のみとするためpre_hookで全件削除する処理を記載

with stg_jugyoin_masta_judgev as (
    select
        jgyinkd::varchar(10) as jgyinkd, -- 従業員コード
        tkyksbi::varchar(8) as tkyksbi, -- 適用開始日
        tkysrybi::varchar(8) as tkysrybi, -- 適用終了日
        jgyinsmiknj::varchar(20) as jgyinsmiknj, -- 従業員氏名_漢字
        jgyinsmirmj::varchar(50) as jgyinsmirmj, -- 従業員氏名_ローマ字
        jgyinkb::varchar(2) as jgyinkb, -- 従業員区分
        kyjgyinkd::varchar(10) as kyjgyinkd, -- 旧従業員コード
        syzkbsykdhnri::varchar(10) as syzkbsykdhnri, -- 所属部署コード_本来
        syzkbsykdsisn::varchar(10) as syzkbsykdsisn, -- 所属部署コード_最新
        kjnkzhyfrg::varchar(1) as kjnkzhyfrg, -- 個人口座保有フラグ
        skk::varchar(2) as skk, -- 資格
        sykikb::varchar(3) as sykikb, -- 職位区分
        syksykb::varchar(2) as syksykb, -- 職種区分
        knmkb::varchar(1) as knmkb, -- 兼務区分
        mradr::varchar(60) as mradr, -- メールアドレス
        sbt::varchar(1) as sbt, -- 性別
        kisykd::varchar(5) as kisykd, -- 会社コード
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp::timestamp as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta021') }}
   where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta021')}})
)
select * from stg_jugyoin_masta_judgev