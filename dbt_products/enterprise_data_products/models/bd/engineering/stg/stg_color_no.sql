
with stg_color_no as (
    select
        gclrno::varchar(6) as gclrno, --カラー№
        datakbn::varchar(1) as datakbn, --データ区分
        syukan::varchar(2) as syukan, --主管会社
        iromei::varchar(25) as iromei, --色名
        oclrno::varchar(20) as oclrno, --オリジナルカラー№
        clrkumi::varchar(18) as clrkumi, --カラー№組合せ１～３
        kihon::varchar(6) as kihon, --室内基本色
        hyohimei::varchar(30) as hyohimei, --表皮名
        sozai::varchar(30) as sozai, --素材名
        maker::varchar(10) as maker, --メーカー名
        siyobui::varchar(30) as siyobui, --使用部位
        ruikbn::varchar(1) as ruikbn, --類別区分
        yoteijiki::varchar(8) as yoteijiki, --設定予定時期
        ssyasyu::varchar(4) as ssyasyu, --設定車種
        ssyamei::varchar(10) as ssyamei, --設定車種車名
        skaisya::varchar(5) as skaisya, --取得会社
        sbusyo::varchar(10) as sbusyo, --取得部署
        ssya::varchar(20) as ssya, --取得者
        _fivetran_synced::timestamp as ldts
    from {{ source('fivetran_database_ritm0274879_oraclerds_lzdata01_sms_dxpfy2d','raw_cyp23colorno') }}
    where _fivetran_deleted = FALSE
)
select * from stg_color_no