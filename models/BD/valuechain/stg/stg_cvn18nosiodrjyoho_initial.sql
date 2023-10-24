with stg_cvn18nosiodrjyoho as (
    select
        *,
        rank() over (partition by ordrkey, juchuymd order by ldts asc) aggkey
    from {{ ref('stg_cvn18nosiodrjyoho') }}
)
select * from stg_cvn18nosiodrjyoho
where aggkey = 1
