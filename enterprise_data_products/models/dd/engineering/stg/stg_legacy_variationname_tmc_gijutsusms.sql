with
    stg_legacy_variationname_gijutsusms as (
        select
            *
        from {{ ref('stg_legacy_variationname_gijutsusms') }}
    ),
    stg_syasyu_tmc_sms as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    stg_legacy_variationname_gijutsusms.*
from stg_legacy_variationname_gijutsusms
inner join stg_syasyu_tmc_sms
    on stg_legacy_variationname_gijutsusms.syasyu_cd = stg_syasyu_tmc_sms.syasyu
