with
    dm_latest_kouseikoutei_plant_syasyu as (
        select * from {{ source('parts_list_db_public','raw_dm_latest_kouseikoutei_plant') }}
         where syasyu_phase in ('30','40')
    ),
    dm_latest_kouseikoutei_plant_ym as (
        select
            kohin,             --品番
            syasyu,            --車種コード
            oyakt,             --親工程
            kumitate,          --組立番号
            bui,               --部位
            vari,              --バリエーション
            std_month,         --最新(N)年月
            0 as sabun,        --差分年月
            n_daisu as daisu,  --N年月台数(生産場所/車種/品番単位)
            kohinmei,          --品名名称
            oyaktmeijp,        --親工程工程符号名称(和)
            oyaktmeien,        --親工程工程符号名称(英)
            jyunbn,            --順引き区分
            seppensyonin_time, --設変承認日
            tkkara             --工場適用カラ
        from dm_latest_kouseikoutei_plant_syasyu ---年月N
    ),
    dm_latest_kouseikoutei_plant_ym1 as (
        select
            kohin,             --品番
            syasyu,            --車種コード
            oyakt,             --親工程
            kumitate,          --組立番号
            bui,               --部位
            vari,              --バリエーション
            std_month,         --最新(N)年月
            -1 as sabun,       --差分年月
            n1_daisu as daisu, --N年月台数(生産場所/車種/品番単位)
            kohinmei,          --品名名称
            oyaktmeijp,        --親工程工程符号名称(和)
            oyaktmeien,        --親工程工程符号名称(英)
            jyunbn,            --順引き区分
            seppensyonin_time, --設変承認日
            tkkara             --工場適用カラ
        from dm_latest_kouseikoutei_plant_syasyu ---年月N-1
    ),
    dm_latest_kouseikoutei_plant_ym2 as (
        select
            kohin,             --品番
            syasyu,            --車種コード
            oyakt,             --親工程
            kumitate,          --組立番号
            bui,               --部位
            vari,              --バリエーション
            std_month,         --最新(N)年月
            -2 as sabun,       --差分年月
            n2_daisu as daisu, --N年月台数(生産場所/車種/品番単位)
            kohinmei,          --品名名称
            oyaktmeijp,        --親工程工程符号名称(和)
            oyaktmeien,        --親工程工程符号名称(英)
            jyunbn,            --順引き区分
            seppensyonin_time, --設変承認日
            tkkara             --工場適用カラ
        from dm_latest_kouseikoutei_plant_syasyu ---年月N-2
    ),
    dm_latest_kouseikoutei_plant_ym3 as (
        select
            kohin,             --品番
            syasyu,            --車種コード
            oyakt,             --親工程
            kumitate,          --組立番号
            bui,               --部位
            vari,              --バリエーション
            std_month,         --最新(N)年月
            -3 as sabun,       --差分年月
            n3_daisu as daisu, --N年月台数(生産場所/車種/品番単位)
            kohinmei,          --品名名称
            oyaktmeijp,        --親工程工程符号名称(和)
            oyaktmeien,        --親工程工程符号名称(英)
            jyunbn,            --順引き区分
            seppensyonin_time, --設変承認日
            tkkara             --工場適用カラ
        from dm_latest_kouseikoutei_plant_syasyu ---年月N-3
    ),
    dm_latest_kouseikoutei_plant_ym4 as (
        select
            kohin,             --品番
            syasyu,            --車種コード
            oyakt,             --親工程
            kumitate,          --組立番号
            bui,               --部位
            vari,              --バリエーション
            std_month,         --最新(N)年月
            -4 as sabun,       --差分年月
            n4_daisu as daisu, --N年月台数(生産場所/車種/品番単位)
            kohinmei,          --品名名称
            oyaktmeijp,        --親工程工程符号名称(和)
            oyaktmeien,        --親工程工程符号名称(英)
            jyunbn,            --順引き区分
            seppensyonin_time, --設変承認日
            tkkara             --工場適用カラ
        from dm_latest_kouseikoutei_plant_syasyu ---年月N-4
    ),
    dm_latest_kouseikoutei_plant_ym5 as (
        select
            kohin,             --品番
            syasyu,            --車種コード
            oyakt,             --親工程
            kumitate,          --組立番号
            bui,               --部位
            vari,              --バリエーション
            std_month,         --最新(N)年月
            -5 as sabun,       --差分年月
            n5_daisu as daisu, --N年月台数(生産場所/車種/品番単位)
            kohinmei,          --品名名称
            oyaktmeijp,        --親工程工程符号名称(和)
            oyaktmeien,        --親工程工程符号名称(英)
            jyunbn,            --順引き区分
            seppensyonin_time, --設変承認日
            tkkara             --工場適用カラ
        from dm_latest_kouseikoutei_plant_syasyu ---年月N-5
    )    
select * from dm_latest_kouseikoutei_plant_ym
union all
select * from dm_latest_kouseikoutei_plant_ym1
union all
select * from dm_latest_kouseikoutei_plant_ym2
union all
select * from dm_latest_kouseikoutei_plant_ym3
union all
select * from dm_latest_kouseikoutei_plant_ym4
union all
select * from dm_latest_kouseikoutei_plant_ym5