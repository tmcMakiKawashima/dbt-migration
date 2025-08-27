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
 --洗い替えのため先に全件削除する処理
 
with stg_eci_hinban as (
    select
        seppenno32::varchar(2) as seppenno32,--設変No.3,2桁目
        seppenno::varchar(10) as seppenno,--設変No.
        jun::varchar(4) as jun,--順
        ecikbn::varchar(3) as ecikbn,--区分
        olvl::varchar(2) as olvl,--旧レベル
        nlvl::varchar(2) as nlvl,--新レベル
        ogc::varchar(2) as ogc,--旧GC
        ngc::varchar(2) as ngc,--新GC
        hokyukbn::varchar(1) as hokyukbn,--補給
        ohinban::varchar(10) as ohinban,--旧品番
        ominor::varchar(2) as ominor,--旧マイナー
        nhinban::varchar(10) as nhinban,--新品番
        nminor::varchar(2) as nminor,--新マイナー
        okosu::varchar(3) as okosu,--旧個数
        nkosu::varchar(3) as nkosu,--新個数
        osentaku::varchar(2) as osentaku,--旧選択
        nsentaku::varchar(2) as nsentaku,--新選択
        hinmei::varchar(40) as hinmei,--品名
        hyougo1::varchar(1) as hyougo1,--変更用語Ⅰ
        hyougo2::varchar(40) as hyougo2,--変更用語Ⅱ
        sonotajp::varchar(50) as sonotajp,--その他（日本語）
        sonotaen::varchar(100) as sonotaen,--その他（英語）
        cond::varchar(30) as cond,--Condition1～10
        mototaio::varchar(3) as mototaio,--元対応
        ninsyo::varchar(1) as ninsyo,--認証
        ogokan::varchar(1) as ogokan,--互換性　旧
        ngokan::varchar(2) as ngokan,--互換性　新
        genka::varchar(1) as genka,--原価変動
        mttime::varchar(16) as mttime,--MT日時
        _fivetran_synced::timestamp_ntz(9) as ldts--最終更新日時
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp17ecihinban') }}
    where _fivetran_deleted = 'false'
)
select * from stg_eci_hinban
