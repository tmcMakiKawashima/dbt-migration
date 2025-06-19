{{
    config (
        materialized = 'incremental',
        unique_key = ['line', 'sno', 'odno', 'ssyy', 'ssmm', 'ssdd', 'symei'],
        incremental_strategy = 'merge'
    )
}}

with stg_vlt_syaryosys as (
    select
        sofc::varchar(2) as sofc, 
        recno::varchar(3) as recno, 
        maker::varchar(4) as maker, 
        line::varchar(2) as line, 
        pcode::varchar(1) as pcode, 
        sno::varchar(2) as sno, 
        odt::varchar(1) as odt, 
        odno::varchar(5) as odno, 
        simei::varchar(1) as simei, 
        ssyy::varchar(2) as ssyy, 
        ssmm::varchar(2) as ssmm, 
        ssdd::varchar(2) as ssdd, 
        dais::varchar(4) as dais, 
        daih::varchar(4) as daih, 
        symei::varchar(2) as symei, 
        gascd::varchar(3) as gascd, 
        dum1::varchar(1) as dum1, 
        frkbn::varchar(3) as frkbn, 
        lktcd::varchar(5) as lktcd, 
        lkata::varchar(15) as lkata, 
        hktcd::varchar(5) as hktcd, 
        hkata::varchar(15) as hkata, 
        ckata::varchar(16) as ckata, 
        gaicd::varchar(4) as gaicd, 
        ucd::varchar(4) as ucd, 
        nisgt::varchar(1) as nisgt, 
        smkcd::varchar(3) as smkcd, 
        smkk::varchar(10) as smkk, 
        steki::varchar(1) as steki, 
        smkbr::varchar(1) as smkbr, 
        kdlkd::varchar(2) as kdlkd, 
        kdlno::varchar(4) as kdlno, 
        kdlsb::varchar(1) as kdlsb, 
        kdsiz::varchar(2) as kdsiz, 
        dskbn::varchar(1) as dskbn, 
        wmi::varchar(3) as wmi, 
        vds::varchar(6) as vds, 
        my::varchar(1) as my, 
        vinkbn::varchar(1) as vinkbn, 
        sketa::varchar(1) as sketa, 
        aite::varchar(2) as aite, 
        unit::varchar(1) as unit, 
        dum2::varchar(1) as dum2, 
        idno::varchar(10) as idno, 
        skata::varchar(10) as skata, 
        jkspc::varchar(200) as jkspc, 
        jhspc::varchar(200) as jhspc, 
        dum3::varchar(9) as dum3, 
        current_timestamp::timestamp_ntz(9) as load_date, 
        ldts, -- B層LDTS
        line_number,
        rank() over(
            partition by 
                line,
                sno,
                odno,
                ssyy,
                ssmm,
                ssdd,
                symei
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa391')}}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey, line_number) from stg_vlt_syaryosys where aggkey = 1