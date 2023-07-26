with DM_YOHINDAIATARI_NEW as (
    select * from {{ref('tmp30_DM_YOHIN_DAIATARI')}}
)
select * from DM_YOHINDAIATARI_NEW