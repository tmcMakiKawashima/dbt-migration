with stg_haisyagenshi as (
    select
        datid::varchar(4) as datid,  -- なし
        yy::varchar(4) as yy,  -- なし
        mm::varchar(2) as mm,  -- なし
        dd::varchar(2) as dd,  -- なし
        hh::varchar(2) as hh,  -- なし
        ff::varchar(2) as ff,  -- なし
        ss::varchar(4) as ss,  -- なし
        try_to_timestamp_ntz(yy||mm||dd||hh||ff||ss , 'yyyymmddhh24missff9') as mtdate, -- timestamp型
        uyy::varchar(4) as uyy,  -- なし
        umm::varchar(2) as umm,  -- なし
        udd::varchar(2) as udd,  -- なし
        uyy||umm||udd as uriageymd,
        odt::varchar(1) as odt,  -- なし
        shamei::varchar(2) as shamei,  -- なし
        sno::varchar(2) as sno,  -- なし
        rtrim(hkata,' 　')::varchar(20) as hkata,  -- 右blank
        rtrim(katacd,' 　')::varchar(5) as katacd,  -- 右blank
        ltrim(gaicd,' 　')::varchar(4) as gaicd,  -- 左blank
        ltrim(ucd,' 　')::varchar(4) as ucd,  -- 左blank
        tire::varchar(3) as tire,  -- なし
        joption::varchar(80) as joption,  -- なし
        hoption::varchar(80) as hoption,  -- なし
        frmkbn::varchar(3) as frmkbn,  -- なし
        frmno::varchar(7) as frmno,  -- なし
        egno::varchar(7) as egno,  -- なし
        smkcd::varchar(5) as smkcd,  -- なし
        zaikosk::varchar(5) as zaikosk,  -- なし
        yusosk::varchar(8) as yusosk,  -- なし
        "ODNO.OSHAMEI"::varchar(1) as odnooshamei,  -- なし
        "ODNO.DFSC"::varchar(5) as odnodfsc,  -- なし
        "ODNO.OMM"::varchar(1) as odnoomm,  -- なし
        "ODNO.OJJ"::varchar(2) as odnoojj,  -- なし
        "ODNO.SERNO"::varchar(3) as odnoserno,  -- なし
        "ODNO.OSHAMEI"||"ODNO.DFSC"||"ODNO.OMM"||"ODNO.OJJ"||"ODNO.SERNO" as orderno,
        ukecd::varchar(1) as ukecd,  -- なし
        tiremk::varchar(1) as tiremk,  -- なし
        chusi::varchar(1) as chusi,  -- なし
        tokcd::varchar(1) as tokcd,  -- なし
        skkbn::varchar(1) as skkbn,  -- なし
        tehkbn::varchar(2) as tehkbn,  -- なし
        rtrim(sketai,' 　')::varchar(3) as sketai,  -- 右blank
        kteki::varchar(1) as kteki,  -- なし
        "HAIKYMD.YY"::varchar(4) as haikymdyy,  -- なし
        "HAIKYMD.MM"::varchar(2) as haikymdmm,  -- なし
        "HAIKYMD.DD"::varchar(2) as haikymddd,  -- なし
        "HAIKYMD.YY"||"HAIKYMD.MM"||"HAIKYMD.DD" as haisyakaitoymd,
        "SYUYMD.YY"::varchar(4) as syuymdyy,  -- なし
        "SYUYMD.MM"::varchar(2) as syuymdmm,  -- なし
        "SYUYMD.DD"::varchar(2) as syuymddd,  -- なし
        "SYUYMD.YY"||"SYUYMD.MM"||"SYUYMD.DD" as syukenymd,
        "HIKYMD.YY"::varchar(4) as hikymdyy,  -- なし
        "HIKYMD.MM"::varchar(2) as hikymdmm,  -- なし
        "HIKYMD.DD"::varchar(2) as hikymddd,  -- なし
        "HIKYMD.YY"||"HIKYMD.MM"||"HIKYMD.DD" as hikitoriymd,
        "HAIYMD.YY"::varchar(4) as haiymdyy,  -- なし
        "HAIYMD.MM"::varchar(2) as haiymdmm,  -- なし
        "HAIYMD.DD"::varchar(2) as haiymddd,  -- なし
        "HAIYMD.YY"||"HAIYMD.MM"||"HAIYMD.DD" as haisyaymd,
        dlrrs::varchar(17) as dlrname,  -- なし
        simnam::varchar(28) as shimukename,  -- なし
        adrjyo::varchar(56) as address,  -- なし
        bukbn::varchar(1) as bukbn,  -- なし
        tecs::varchar(1) as tecs,  -- なし
        kmkr::varchar(5) as kasomaker,  -- なし
        kukcd::varchar(1) as kukcd,  -- なし
        wax::varchar(1) as wax,  -- なし
        seikyu::varchar(5) as seikyu,  -- なし
        wrap::varchar(1) as wrap,  -- なし
        ldts, -- b層のldts
        rank() over (
                partition by
                    frmno, hkata, frmkbn, shamei, sno, sketai
                order by ldts desc, mtdate desc
            ) aggkey
        from {{ ref('substr_tsjfa368') }}
    )
select *
from stg_haisyagenshi
where aggkey = 1