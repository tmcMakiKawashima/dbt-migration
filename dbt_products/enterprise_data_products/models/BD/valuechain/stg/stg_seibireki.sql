{{
    config(
        materialized = 'incremental',
        unique_key = ['nyukono','meisaino'],
        incremental_strategy = 'merge'
    )
}}

with stg_seibireki as (
    select
        r001::varchar(9) as nyukono,
        r002::varchar(4) as meisaino,
        r003::varchar(11) as sobinamesansyocd,
        rtrim(r004, ' 　')::varchar(8) as seibicd, -- 右blank
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        ldts,
        row_number,
        rank() over (partition by nyukono, meisaino order by ldts desc, row_number desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3206') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * exclude(aggkey, row_number)
from stg_seibireki
where aggkey = 1