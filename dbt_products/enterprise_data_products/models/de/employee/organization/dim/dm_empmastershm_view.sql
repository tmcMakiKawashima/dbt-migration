{{
    config (
        materialized = 'view',
    )
}}
with
    dm_empmastershm_view as (
        select 
            sha2(jcd) as jcd
            ,hyjykjnam
            ,hyjyknnam
            ,hyjyrmnam
            ,shgaishkbncd
            ,shgaishkbnnam
            ,hriszcd
            ,bmncd
            ,bmnnam
            ,rskbmnnam
            ,bucd
            ,sskbunam1
            ,rskbunam
            ,stkcd
            ,sskstknam
            ,rskstknam
            ,stkkbncd
            ,kkrgcd
            ,sskkkrgnam
            ,rskkrgnam
            ,kmcd
            ,ebnsms1
            ,ebnsms2
            ,ltszcd
            ,sbucd
            ,ssskbunam1
            ,srskbunam
            ,sstkcd
            ,ssskstknam
            ,srskstknam
            ,skkrgcd
            ,ssskkkrgnam
            ,srskkrgnam
            ,loccd
            ,locnam
            ,kaisyacd
            ,szkkshm
            ,sykicd
            ,sykinam
            ,emailadr
            ,jsjcdbu
            ,jsnambu
            ,jssykibu
            ,jsemailbu
            ,jsjcdst
            ,jsnamst
            ,jssykist
            ,jsemailst
            ,jsjcdkkg
            ,jsnamkkg
            ,jssykikkg
            ,jsemailkkg
        from {{  source('administration_db_public','raw_empmastershm') }}
        where load_end_date is null
        and (shgaishkbncd is null or shgaishkbncd in('1','2','3','4','5','6'))
    )
select * from dm_empmastershm_view