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
                SUM(COALESCE(SYUKAJ,0))
                + SUM(COALESCE(FOLLOW1,0))
                + SUM(COALESCE(FOLLOW2,0))
                + SUM(COALESCE(FOLLOW3,0))
              ) SYUKKOSU
            , MAX(
                  LPAD(rtrim("SDATE-Y"),length("SDATE-Y"),'0') ||
                  LPAD(rtrim("SDATE-M"),length("SDATE-M"),'0') ||
                  LPAD(rtrim("SDATE-D"),length("SDATE-D"),'0') 
              ) SYUKKOYMD
        from {{ ref('stg_tbnsyus') }}
        where
            GDENK IN ('01', '05', '11')
            and DSYUBETS  = '1'
        group by ALL
    )

select * from NY
