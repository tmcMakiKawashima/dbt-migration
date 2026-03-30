with
    stg_matocode_gijutsusms as (
        select
            *
        from {{ ref('stg_matocode_gijutsusms') }}
    ),
    stg_syasyu_tmc_sms as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    stg_matocode_gijutsusms.*
from stg_matocode_gijutsusms
inner join stg_syasyu_tmc_sms
    on stg_matocode_gijutsusms.syasyu = stg_syasyu_tmc_sms.syasyu
