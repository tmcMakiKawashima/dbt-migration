{{ config(fail_calc = "cnt") }}

select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where JUCHUSU > M_SYUKKASU
    and M_SYUKKASU is not null --←『[TMP]受注数に対して[メーカー]出荷数が小さい場合』の条件があるため不要では？
    and JUCHUSU - M_SYUKKASU != M_BOSU