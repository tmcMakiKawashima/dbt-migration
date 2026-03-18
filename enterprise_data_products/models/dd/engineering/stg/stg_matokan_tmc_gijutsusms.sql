with
    matokan as (
        select
            *
        from {{ ref('stg_matokan_gijutsusms') }}
    ),
    syasyu_tmc as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    matokan.*
from matokan
inner join syasyu_tmc
    on matokan.syasyu = syasyu_tmc.syasyu
