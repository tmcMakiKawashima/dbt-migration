{{ config(fail_calc = "cnt") }}

select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where M_SYUKKASU is not null
    and NYUKOSU is not null
    and (
      M_SYUKKASU > JUCHUSU
      or NYUKOSU > JUCHUSU
    )