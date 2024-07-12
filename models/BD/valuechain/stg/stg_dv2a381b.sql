{{ config(materialized='incremental') }}

with stg_dv2a381b as (
    select *,
        row_number() over(
            partition by ctlgcd, hinmeicd, syasyu_cd, hinban, kosu, jissijikik, jissijikim, siyoptno, epckataptno, kiricdk, kiricdm, trmcdmlt, clrcdmlt, tkstkbn, hktkgaikbn, hosemhin, ldts
                order by
                    case mntkbn
                        when 'D' then 1
                        when 'U' then 2
                        when 'C' then 3
                    end
        ) rn
    from {{ ref('substr_dv2a381b') }}
    order by ldts asc, rn asc
)
select * exclude(rn) from stg_dv2a381b

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}