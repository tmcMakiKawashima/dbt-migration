{{ config(fail_calc = "cnt")}}
select count(*) as cnt
    from
    (
        select *
        from
        ( select * from {{ref('tmp40_dm_tmc_tyokuso_jutyunokikaito')}}
        where siirecd not in ('2281', '4033') --仕入先CD
        and substr(dlrcd, 1, 5) not in ('85121', '85911') --仕向先CD
    ) where keikanissu <> '1' --経過日数
    )