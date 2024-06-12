{{
    config(
        materialized = 'incremental',
        unique_key = ['nyukohanbaitencd', 'jutyuno', 'seisany', 'seisanmd', 'nyukono'],
        incremental_strategy = 'merge'
    )
}}

with stg_nyukomeisaisakuin as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(R001, ' 　')::varchar(5) as nyukohanbaitencd,
        rtrim(R002, ' 　')::varchar(8) as jutyuno,
        rtrim(R003, ' 　')::varchar(4) as seisany,
        rtrim(R004, ' 　')::varchar(4) as seisanmd,
        seisany||seisanmd::varchar(8) as seisanymd,
        rtrim(R005, ' 　')::varchar(9) as nyukono,
        ldts,
        rank() over (partition by nyukohanbaitencd, jutyuno, seisany, seisanmd, nyukono order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3203') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)
select * from stg_nyukomeisaisakuin where aggkey = 1