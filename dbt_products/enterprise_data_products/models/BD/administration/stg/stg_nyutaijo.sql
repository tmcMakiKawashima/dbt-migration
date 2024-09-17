{{ config(materialized='incremental') }}
with stg_nyutaijo as (
    select
        ckaishacd::varchar(4) as ckaishacd,
        cuserid::varchar(7) as employee_cd,
        cdatetime::varchar(14) as cdatetime,
        cinoutflg::varchar(1) as cinoutflg,
        ctanmatsucd::varchar(6) as ctanmatsucd,
        ldts
    from {{ ref('substr_jf04455d') }}
)
select * from stg_nyutaijo

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}