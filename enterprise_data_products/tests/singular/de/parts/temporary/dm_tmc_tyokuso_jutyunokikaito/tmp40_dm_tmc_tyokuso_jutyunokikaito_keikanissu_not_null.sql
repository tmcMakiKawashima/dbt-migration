{{ config(fail_calc = "cnt")}}

select count(*) as cnt
    from
    (
        select *
        from
        ( select * from {{ref('tmp40_dm_tmc_tyokuso_jutyunokikaito')}}
        where siirecd in ('2281', '4033') --仕入先CD
    ) where keikanissu is null --経過日数
    )