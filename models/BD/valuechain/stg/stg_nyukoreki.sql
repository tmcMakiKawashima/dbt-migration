{{
    config(
        materialized = 'incremental',
        unique_key = ['kbsyadai', 'nosyadai', 'seisanymd', 'nyukohanbaitencd', 'jutyuno'],
        incremental_strategy = 'merge'
    )
}}

with stg_nyukoreki as (
    select
        r001::varchar(3) as kbsyadai,
        rtrim(r002, ' 　')::varchar(20) as nosyadai, -- 右blank
        split_part(nosyadai, '-', 1) as syadai_kt, -- 車台番号ハイフンの左
        split_part(nosyadai, '-', 2) as frmno, -- 車台番号(trim後）ハイフンの右
        r003::varchar(8) as seisanymd,
        r004::varchar(5) as nyukohanbaitencd,
        r005::varchar(8) as jutyuno,
        rtrim(r006, ' 　')::varchar(3) as uketsuketenpocd, -- 右blank
        r007::varchar(3) as ikansakitenpocd,
        r008::varchar(1) as nyukokbn,
        r009::varchar(8) as nyukoyoteiymd,
        r010::varchar(8) as uketsukeymd,
        r011::varchar(6) as soukoukm,
        r012::varchar(7) as daiagcd1,
        r013::varchar(7) as daiagcd2,
        r014::varchar(7) as daiagcd3,
        r015::varchar(7) as daiagcd4,
        r016::varchar(7) as daiagcd5,
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        ldts,
        row_number,
        rank() over (partition by kbsyadai, nosyadai, nyukohanbaitencd, jutyuno order by ldts desc, row_number desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3202') }}

    {% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
    {% endif %}
)

select * exclude(row_number, aggkey)
from stg_nyukoreki 
where aggkey = 1