with stg_nyukoreki as (
    select
        iff(rtrim(delflg, ' 　') = 'D', '1', '0')::varchar(1) as delflg,
        rtrim(KBSYADAI, ' 　')::varchar(3) as KBSYADAI,
        rtrim(NOSYADAI, ' 　')::varchar(20) as NOSYADAI,
        split_part(NOSYADAI, '-', 1) as syadai_kt,
        split_part(NOSYADAI, '-', 2) as frmno,
        rtrim(seisanymd, ' 　')::varchar(8) as seisanymd,
        rtrim(nyukohanbaitencd, ' 　')::varchar(5) as nyukohanbaitencd,
        rtrim(jutyuno, ' 　')::varchar(8) as jutyuno,
        rtrim(uketsuketenpocd, ' 　')::varchar(3) as uketsuketenpocd,
        rtrim(ikansakitenpocd, ' 　')::varchar(3) as ikansakitenpocd,
        rtrim(nyukokbn, ' 　')::varchar(1) as nyukokbn,
        rtrim(nyukoyoteiymd, ' 　')::varchar(8) as nyukoyoteiymd,
        rtrim(uketsukeymd, ' 　')::varchar(8) as uketsukeymd,
        rtrim(soukoukm, ' 　')::varchar(6) as soukoukm,
        rtrim(daiagcd1, ' 　')::varchar(7) as daiagcd1,
        rtrim(daiagcd2, ' 　')::varchar(7) as daiagcd2,
        rtrim(daiagcd3, ' 　')::varchar(7) as daiagcd3,
        rtrim(daiagcd4, ' 　')::varchar(7) as daiagcd4,
        rtrim(daiagcd5, ' 　')::varchar(7) as daiagcd5,
        ldts,
        rank() over (partition by KBSYADAI, NOSYADAI, seisanymd, nyukohanbaitencd, jutyuno order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3202') }}
)
select * from stg_nyukoreki
where aggkey = 1
