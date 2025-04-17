with stg_yosankmk_masta_judgev as (
    select
        ysnkomkkd::varchar(6) as ysnkomkkd, -- 予算項目コード
        tkyksbi::varchar(8) as tkyksbi, -- 適用開始日
        ysnkomkmi::varchar(30) as ysnkomkmi, -- 予算項目名
        hmkkd::varchar(3) as hmkkd, -- 費目コード
        hmkkb::varchar(2) as hmkkb, -- 費目区分
        ysnkb::varchar(2) as ysnkb, -- 予算区分
        sndnbnri::varchar(1) as sndnbnri, -- 宣伝分類
        ysnksnkb::varchar(1) as ysnksnkb, -- 予算更新区分
        niystm::varchar(60) as niystm, -- 内容説明
        tkysrybi::varchar(8) as tkysrybi, -- 適用終了日
        ksnbi::varchar(8) as ksnbi, -- 更新日
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp::timestamp as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'ktrla02kzz0kgta025') }}
   where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'ktrla02kzz0kgta025')}})
)
select * from stg_yosankmk_masta_judgev