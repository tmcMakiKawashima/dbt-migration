with
    matojyoken as (
        select
            *
        from {{ ref('stg_matojyoken_gijutsusms') }}
    ),
    syasyu_tmc as (
        select
            syasyu
        from {{ ref('stg_syasyu_tmc_sms') }}
    )
select
    matojyoken.*
from matojyoken
inner join syasyu_tmc
    on matojyoken.syasyu = syasyu_tmc.syasyu
