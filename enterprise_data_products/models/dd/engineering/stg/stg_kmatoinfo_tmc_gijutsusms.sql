with
    matoinfo as (
        select
            *
        from {{ ref('stg_kmatoinfo_gijutsusms') }}
    ),
    syasyu_tmc as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    matoinfo.*
from matoinfo
inner join syasyu_tmc
    on matoinfo.syasyu = syasyu_tmc.syasyu
