with dm_kousei_jyufukublktenkai as (
    select * from {{ref('dm_kousei_jyufukublktenkai')}}
), stg_syasyu_tmc_sms as (
    select * from {{ref('stg_syasyu_tmc_sms')}}
)
select ks.*
from dm_kousei_jyufukublktenkai as ks
inner join stg_syasyu_tmc_sms as sy
on ks.syasyu = sy.syasyu