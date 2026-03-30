with
    stg_matojyoken_gijutsusms as (
        select
            *
        from {{ ref('stg_matojyoken_gijutsusms') }}
    ),
    stg_syasyu_tmc_sms as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    stg_matojyoken_gijutsusms.*
from stg_matojyoken_gijutsusms
inner join stg_syasyu_tmc_sms
    on stg_matojyoken_gijutsusms.syasyu = stg_syasyu_tmc_sms.syasyu
