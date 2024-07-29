{{ config(snowflake_warehouse='DBT_WH') }}

with
    NY as (
        select
            --temp50での結合処理用 
            KYOUHAN
            , USRCOD
            , HANABAI
            , DENNOJ
            , HINBAN
            --    
            , MAKERCD
            , (
                COALESCE(IFF("SYUKAJ-S" = '-', SYUKAJ * -1, SYUKAJ), 0)
                + COALESCE(IFF("FOLLOW1-S" = '-', FOLLOW1 * -1, FOLLOW1), 0)
                + COALESCE(IFF("FOLLOW2-S" = '-', FOLLOW2 * -1, FOLLOW2), 0)
                + COALESCE(IFF("FOLLOW3-S" = '-', FOLLOW3 * -1, FOLLOW3), 0)
            ) SYUKKOSU
            , (
                LPAD(rtrim("SDATE-Y"), length("SDATE-Y"), '0') ||
                LPAD(rtrim("SDATE-M"), length("SDATE-M"), '0') ||
                LPAD(rtrim("SDATE-D"), length("SDATE-D"), '0') 
            ) SYUKKOYMD
        from {{ ref('stg_tbnsyus') }}
        where
            GDENK IN ('01', '05', '11')
            and DSYUBETS = '1'
    )

select * from NY
