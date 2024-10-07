{{ config(materialized='incremental') }}

with stg_kirikaecodekensaku as (
    select *,
        row_number() over(
            partition by ctlgcd, kiricd, prtren, ldts
                order by
                    case mntkbn
                        when 'D' then 1
                        when 'U' then 2
                        when 'C' then 3
                    end
        ) rn
    from {{ ref('substr_dv2a3704') }}
    order by ldts asc, rn asc
)
select * exclude(rn) from stg_kirikaecodekensaku

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}