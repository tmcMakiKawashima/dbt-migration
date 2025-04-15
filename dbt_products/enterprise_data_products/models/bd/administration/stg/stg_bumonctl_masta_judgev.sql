with stg_bumonctl_masta_judgev as (
    select
        ysnkb::varchar(2) as ysnkb, -- 予算区分
        ysnbmnkd::varchar(5) as ysnbmnkd, -- 予算部門コード
        tkyksbi::varchar(8) as tkyksbi, -- 適用開始日
        trkkd::varchar(5) as trkkd, -- 登録コード
        bukd::varchar(5) as bukd, -- 部コード
        sktbsykd::varchar(5) as sktbsykd, -- 総括部署コード
        bmnkb::varchar(2) as bmnkb, -- 部門区分
        tkysrybi::varchar(8) as tkysrybi, -- 適用終了日
        ksnbi::varchar(8) as ksnbi, -- 更新日
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp::timestamp as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'ktrla02kzz0kgta023') }}
   where ldts = (select max(ldts) from {{ source('snowpipe_db_administration', 'ktrla02kzz0kgta023') }}) 
)
select * from stg_bumonctl_masta_judgev