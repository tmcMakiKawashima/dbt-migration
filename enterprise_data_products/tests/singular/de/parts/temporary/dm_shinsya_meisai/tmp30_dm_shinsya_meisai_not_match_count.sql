{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
        select count(*) as cnt
        from {{ref('tmp20_dm_shinsya_meisai')}}
        where rnk = 1
    ) a, (
        select count(*) as cnt
        from {{ref('tmp30_dm_shinsya_meisai')}}
    ) b