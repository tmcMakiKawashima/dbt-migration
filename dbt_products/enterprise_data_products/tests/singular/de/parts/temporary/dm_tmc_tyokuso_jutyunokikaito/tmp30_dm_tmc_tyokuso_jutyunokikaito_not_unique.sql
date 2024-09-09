{{config(fail_calc="cnt")}}

select count(*) as cnt
    from
    (
        select
            dlrcd, ordesybt, yusokbn, ordeno, juchuymd, iff(jhinban = '', jhinban, shinban) as hinban
            from {{ref('tmp30_dm_tmc_tyokuso_jutyunokikaito')}}
            where jsksyseiymd = ''
            group by dlrcd, ordesybt, yusokbn, ordeno, juchuymd, hinban
            having count(*) > 1
    )
