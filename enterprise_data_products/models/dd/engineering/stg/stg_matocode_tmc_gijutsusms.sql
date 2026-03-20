with
    matocode as (
        select
            *
        from {{ ref('stg_matocode_gijutsusms') }}
    ),
    syasyu_tmc as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    matocode.*
from matocode
inner join syasyu_tmc
    on matocode.syasyu = syasyu_tmc.syasyu
