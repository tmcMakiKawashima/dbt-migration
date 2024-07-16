{{ config(materialized='incremental') }}

with stg_dv2a4983 as (
    select *,
        row_number() over(
            partition by hinban, dntikicd, cthin, ldts
                order by
                    case mntkbn
                        when 'D' then 1
                        when 'U' then 2
                        when 'C' then 3
                    end
        ) rn
    from {{ ref('substr_dv2a4983') }}
    order by ldts asc, rn asc
)
select * exclude(rn) from stg_dv2a4983

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}