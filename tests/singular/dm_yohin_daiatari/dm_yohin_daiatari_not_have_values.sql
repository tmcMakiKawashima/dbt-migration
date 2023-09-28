{{ config(fail_calc = "cnt") }}

select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where M_TKSKBN in ('1', '3') --一般：'1', 新直送：'3'
    and NYUKOYMD is not null
    and (
      M_JHINBAN is null
      or M_SHINBAN is null
      or M_JUCHUYMD is null
      or M_SYUKKAYMD is null
      or M_SYUKKASU is null
      or NYUKOSU is null
      or M_KAKNOUKBN is null
      or M_THIBUSYOCD is null
      or M_THITATOCD is null
      or M_TEHAIKBN is null
    )