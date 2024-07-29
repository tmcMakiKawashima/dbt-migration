-- データ結合２ 1-1
{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
        select count(*) as cnt
        from {{ref('tmp10_dm_tmc_tyokuso_jutyunokikaito')}}
    ) a, (
        select count(*) as cnt
        from {{ref('tmp15_dm_tmc_tyokuso_jutyunokikaito')}}
    ) b