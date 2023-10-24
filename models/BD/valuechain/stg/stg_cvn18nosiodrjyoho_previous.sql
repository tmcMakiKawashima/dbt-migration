with stg_cvn18nosiodrjyoho as (
    select
        *,
        rank() over (partition by ordrkey, juchuymd order by ldts desc) aggkey
    from {{ ref('stg_cvn18nosiodrjyoho') }}
    where
        (ordrkey, juchuymd, nosikbn) not in (
            select ordrkey, juchuymd, nosikbn
            from {{ ref('stg_cvn18nosiodrjyoho_latest') }}
        )
)
select * from stg_cvn18nosiodrjyoho
where aggkey = 1
