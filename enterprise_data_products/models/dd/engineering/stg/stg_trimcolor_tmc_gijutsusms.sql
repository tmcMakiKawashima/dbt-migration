with
    trimcolor as (
        select
            *
        from {{ ref('stg_trimcolor_gijutsusms') }}
    ),
    syasyu_tmc as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    trimcolor.*
from trimcolor
inner join syasyu_tmc
    on trimcolor.syasyu = syasyu_tmc.syasyu
