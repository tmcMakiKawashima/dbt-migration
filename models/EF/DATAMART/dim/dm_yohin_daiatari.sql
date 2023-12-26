with dm_yohindaiatari_new as (
    select * from {{ref('tmp30_dm_yohin_daiatari')}}
)
select * from dm_yohindaiatari_new
order by usercd, kaisya, dlrcd, tchumon, juchuymd, hinban, chumon, hachuymd