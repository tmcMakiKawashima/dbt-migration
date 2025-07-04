with stg_siyoumst_check as (
    select
        mtkbn::varchar(1) as mtkbn, --C,U,Dのメンテ区分
        segmei::varchar(8) as segmei,
        renkey_hkata::varchar(20) as renkey_hkata,
        renkey_sedai::varchar(1) as renkey_sedai,
        renkey_psign::varchar(1) as renkey_psign,
        renkey_keykbn::varchar(1) as renkey_keykbn,
        renkey_chk::varchar(5) as renkey_chk,
        renkey_renban::varchar(2) as renkey_renban,
        psign::varchar(1) as psign,
        keykbn::varchar(1) as keykbn,
        chk::varchar(5) as chk,
        renban::varchar(2) as renban,
        jkkyy::varchar(4) as jkkyy,
        jkkmm::varchar(2) as jkkmm,
        jkkdd::varchar(2) as jkkdd,
        jkmyy::varchar(4) as jkmyy,
        jkmmm::varchar(2) as jkmmm,
        jkmdd::varchar(2) as jkmdd,
        dkkyy::varchar(4) as dkkyy,
        dkkmm::varchar(2) as dkkmm,
        dkkdd::varchar(2) as dkkdd,
        dkmyy::varchar(4) as dkmyy,
        dkmmm::varchar(2) as dkmmm,
        dkmdd::varchar(2) as dkmdd,
        setkbn1::varchar(1) as setkbn1,
        seiyak1::varchar(4) as seiyak1,
        setkbn2::varchar(1) as setkbn2,
        seiyak2::varchar(4) as seiyak2,
        setkbn3::varchar(1) as setkbn3,
        seiyak3::varchar(4) as seiyak3,
        setkbn4::varchar(1) as setkbn4,
        seiyak4::varchar(4) as seiyak4,
        setkbn5::varchar(1) as setkbn5,
        seiyak5::varchar(4) as seiyak5,
        setkbn6::varchar(1) as setkbn6,
        seiyak6::varchar(4) as seiyak6,
        setkbn7::varchar(1) as setkbn7,
        seiyak7::varchar(4) as seiyak7,
        ldts,
        row_number() over (
            partition by 
                segmei, renkey_hkata, renkey_sedai, renkey_psign, renkey_keykbn, renkey_chk, renkey_renban, ldts
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_tsjfa38t2') }}
        where rtrim(segmei,' 　') = 'EA31023'
)
select * exclude(aggkey,mtkbn)
from stg_siyoumst_check
where aggkey = 1 and mtkbn in ('C','U')