with
    stg_matokan_gijutsusms as (
        select
            *
        from {{ ref('stg_matokan_gijutsusms') }}
    ),
    stg_syasyu_tmc_sms as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    stg_matokan_gijutsusms.*
from stg_matokan_gijutsusms
inner join stg_syasyu_tmc_sms
    on stg_matokan_gijutsusms.syasyu = stg_syasyu_tmc_sms.syasyu
