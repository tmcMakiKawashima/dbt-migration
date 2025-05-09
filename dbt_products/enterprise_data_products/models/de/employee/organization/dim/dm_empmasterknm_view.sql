{{
    config (
        materialized = 'view',
    )
}}
with
    dm_empmasterknm_view as (
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
        from {{ source('administration_db_public','raw_empmasterknm') }}
        where load_end_date is null
    )
select * from dm_empmasterknm_view