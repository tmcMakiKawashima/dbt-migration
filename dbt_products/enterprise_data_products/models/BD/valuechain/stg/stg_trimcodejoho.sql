{{ config(materialized='incremental') }}

with stg_trimcodejoho as (
    select *,
        row_number() over(
            partition by ctlgcd, syasyu_cd, hinban, trmcd, figno, ldts
                order by
                    case mntkbn
                        when 'D' then 1
                        when 'U' then 2
                        when 'C' then 3
                    end
        ) rn
    from {{ ref('substr_dv2a38b4') }}
    order by ldts asc, rn asc
)
select * exclude(rn) from stg_trimcodejoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}