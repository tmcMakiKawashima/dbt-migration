with stg_usercode_koumusms as (
    select
        jigyoutaicd::varchar(2) as jigyoutaicd, --事業体コード
        kouku::varchar(1) as kouku, --工区
        renban::varchar(1) as renban, --連番
        kanrikt::varchar(6) as kanrikt, --管理工程
        konpouflg::varchar(1) as konpouflg, --梱包工程ＦＬＧ
        dhktzokusei::varchar(1) as ktzokusei, --工程属性
        sakuseitime::varchar(16) as sakuseitime, --作成日時
        kousintime::varchar(16) as kousintime, --更新日時
        timestamp::timestamp_ntz(9) as timestamp --最終更新日時
    from {{ source('manufacturing_db_public','raw_m_cb408pusercode') }}
)
select * from stg_usercode_koumusms
