{{ config(fail_calc = "cnt") }}

select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where M_SYUKKASU = NYUKOSU
    and M_SYUKKAYMD > NYUKOYMD