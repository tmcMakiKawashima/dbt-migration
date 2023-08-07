with DM_YOHINDAIATARI_NEW as (
    select * from {{ref('tmp30_dm_yohin_daiatari')}}
)
select * from DM_YOHINDAIATARI_NEW