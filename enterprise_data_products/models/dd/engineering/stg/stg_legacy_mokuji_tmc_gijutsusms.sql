with legacy_mokuji  as (
    select
        *
    from {{ ref('stg_legacy_mokuji_gijutsusms') }}
),
syasyu_tmc as (
    select
        syasyu
    from {{ ref('stg_syasyu_tmc_sms') }}
)
select
    legacy_mokuji.*
from legacy_mokuji
inner join syasyu_tmc
    on legacy_mokuji.syasyu = syasyu_tmc.syasyu