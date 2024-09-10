{{ config(materialized='incremental') }}

with stg_hinbankensakutype2 as (
    select *,
        row_number() over(
            partition by langkbn, ctlgcd, hinmeicd, syasyu_cd, hinban, kosu, jissijikik, jissijikim, siyoptno, epckataptno, kiricdk, kiricdm, trmcdmlt, clrcdmlt, tkstkbn, hktkgaikbn, hosemhin, ldts
                order by
                    case mntkbn
                        when 'D' then 1
                        when 'U' then 2
                        when 'C' then 3
                    end
        ) rn
    from {{ ref('substr_cv201khintype2') }}
    order by ldts asc, rn asc
)
select * exclude(rn) from stg_hinbankensakutype2

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}