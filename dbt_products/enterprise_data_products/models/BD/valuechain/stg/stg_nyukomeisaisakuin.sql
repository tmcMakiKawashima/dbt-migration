{{
    config(
        materialized = 'incremental',
        unique_key = ['nyukohanbaitencd', 'jutyuno', 'seisany', 'seisanmd', 'nyukono'],
        incremental_strategy = 'merge'
    )
}}

with stg_nyukomeisaisakuin as (
    select
        r001::varchar(5) as nyukohanbaitencd,
        r002::varchar(8) as jutyuno,
        r003::varchar(4) as seisany,
        r004::varchar(4) as seisanmd,
        r003||r004::varchar(8) as seisanymd,
        r005::varchar(9) as nyukono,
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        ldts,
        row_number,
        rank() over (partition by nyukohanbaitencd, jutyuno, nyukono order by ldts desc, row_number desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3203') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)

select * exclude(row_number, aggkey) 
from stg_nyukomeisaisakuin 
where aggkey = 1