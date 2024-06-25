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
        R001::varchar(3) as KBSYADAI,
        rtrim(R002, ' 　')::varchar(20) as NOSYADAI, -- 右blank
        split_part(NOSYADAI, '-', 1) as syadai_kt, -- 車台番号ハイフンの左
        split_part(NOSYADAI, '-', 2) as frmno, -- 車台番号(trim後）ハイフンの右
        R003::varchar(8) as seisanymd,
        R004::varchar(5) as nyukohanbaitencd,
        R005::varchar(8) as jutyuno,
        R006::varchar(3) as uketsuketenpocd,
        R007::varchar(3) as ikansakitenpocd,
        R008::varchar(1) as nyukokbn,
        R009::varchar(8) as nyukoyoteiymd,
        R010::varchar(8) as uketsukeymd,
        R011::varchar(6) as soukoukm,
        R012::varchar(7) as daiagcd1,
        R013::varchar(7) as daiagcd2,
        R014::varchar(7) as daiagcd3,
        R015::varchar(7) as daiagcd4,
        R016::varchar(7) as daiagcd5,
        ldts,
        rank() over (partition by KBSYADAI, NOSYADAI, seisanymd, nyukohanbaitencd, jutyuno order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3202') }}

    {% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * from stg_nyukoreki where aggkey = 1