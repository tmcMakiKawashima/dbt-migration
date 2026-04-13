with
    stg_kmatoinfo_gijutsusms as (
        select
            *
        from {{ ref('stg_kmatoinfo_gijutsusms') }}
    ),
    stg_syasyu_tmc_sms as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    stg_kmatoinfo_gijutsusms.*
from stg_kmatoinfo_gijutsusms
inner join stg_syasyu_tmc_sms
    on stg_kmatoinfo_gijutsusms.syasyu = stg_syasyu_tmc_sms.syasyu
