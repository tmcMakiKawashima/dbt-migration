with
    stg_matrix_gijutsusms as (
        select
            *
        from {{ ref('stg_matrix_gijutsusms') }}
    ),
    stg_syasyu_tmc_sms as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    stg_matrix_gijutsusms.*
from stg_matrix_gijutsusms
inner join stg_syasyu_tmc_sms
    on stg_matrix_gijutsusms.syasyu = stg_syasyu_tmc_sms.syasyu
