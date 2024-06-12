{{
    config(
        materialized = 'incremental',
        unique_key = ['KBSYADAI', 'NOSYADAI', 'seisanymd', 'nyukohanbaitencd', 'jutyuno'],
        incremental_strategy = 'merge'
    )
}}


with stg_nyukoreki as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(R001, ' 　')::varchar(3) as KBSYADAI,
        rtrim(R002, ' 　')::varchar(20) as NOSYADAI,
        split_part(NOSYADAI, '-', 1) as syadai_kt,
        split_part(NOSYADAI, '-', 2) as frmno,
        rtrim(R003, ' 　')::varchar(8) as seisanymd,
        rtrim(R004, ' 　')::varchar(5) as nyukohanbaitencd,
        rtrim(R005, ' 　')::varchar(8) as jutyuno,
        rtrim(R006, ' 　')::varchar(3) as uketsuketenpocd,
        rtrim(R007, ' 　')::varchar(3) as ikansakitenpocd,
        rtrim(R008, ' 　')::varchar(1) as nyukokbn,
        rtrim(R009, ' 　')::varchar(8) as nyukoyoteiymd,
        rtrim(R010, ' 　')::varchar(8) as uketsukeymd,
        rtrim(R011, ' 　')::varchar(6) as soukoukm,
        rtrim(R012, ' 　')::varchar(7) as daiagcd1,
        rtrim(R013, ' 　')::varchar(7) as daiagcd2,
        rtrim(R014, ' 　')::varchar(7) as daiagcd3,
        rtrim(R015, ' 　')::varchar(7) as daiagcd4,
        rtrim(R016, ' 　')::varchar(7) as daiagcd5,
        ldts,
        rank() over (partition by KBSYADAI, NOSYADAI, seisanymd, nyukohanbaitencd, jutyuno order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3202') }}

    {% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * from stg_nyukoreki where aggkey = 1