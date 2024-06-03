{{
    config (
        materialized = 'incremental',
        unique_key = ['hanbaino'],
        incremental_strategy = 'merge'
    )
}}

with stg_hakkosyonin as (
    select
        hanbaino::varchar(11) as hanbaino,
        syasyu::varchar(4) as syasyu,
        kategoricd::varchar(1) as kategoricd,
        kscd::varchar(1) as kscd,
        mhanbaino::varchar(11) as mhanbaino,
        mbhanbaino::varchar(11) as mbhanbaino,
        mhanbainoed::varchar(11) as mhanbainoed,
        kirikaeym::varchar(6) as kirikaeym,
        kirikaeno::varchar(3) as kirikaeno,
        setsuhenno::varchar(3) as setsuhenno,
        shijikbn::varchar(1) as shijikbn,
        shijino::varchar(9) as shijino,
        clrshkbn::varchar(1) as clrshkbn,
        seppenno::varchar(10) as seppenno,
        clrshijino::varchar(9) as clrshijino,
        hhakkouymd::varchar(14) as hhakkouymd,
        edptnno::varchar(3) as edptnno,
        setsikisflg::varchar(1) as setsikisflg,
        hikilcymd::varchar(14) as hikilcymd,
        hikilc::varchar(1) as hikilc,
        siyolcymd::varchar(14) as siyolcymd,
        siyolc::varchar(1) as siyolc,
        uchibariflg::varchar(1) as uchibariflg,
        release_flg::varchar(1) as release_flg,
        hkakuteiymd::varchar(14) as hkakuteiymd,
        rmailflg::varchar(1) as rmailflg,
        kataaddflg::varchar(1) as kataaddflg,
        katadelflg::varchar(1) as katadelflg,
        cd_sksifunc::varchar(9) as cd_sksifunc,
        cd_ksnfunc::varchar(9) as cd_ksnfunc,
        cd_sksisya::varchar(16) as cd_sksisya,
        cd_ksnsya::varchar(16) as cd_ksnsya,
        dt_sakusei::varchar(26) as dt_sakusei,
        try_to_timestamp_ntz(dt_kosin, 'yyyy-mm-dd-hh24.mi.ss.ff9') as dt_kosin, -- timestamp型
        ldts, -- B層LDTS
        row_number() over(
            partition by hanbaino
            order by ldts desc
        ) aggkey
    from {{ref('substr_n8jfim01')}}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_hakkosyonin where aggkey = 1