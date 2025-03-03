{{ config(
       materialized ='incremental',
       unique_key = ['dlrcd','cuno'],
       incremental_strategy = 'merge'
  ) }}
  
with stg_shinsyameisai as (
    select
        mntkbn::varchar(1) as mntkbn, --なし
        dlrcd::varchar(5) as dlrcd, --なし
        rtrim(cuno, ' 　')::varchar(12) as cuno, -- 右ブランク
        edano::varchar(2) as edano, --なし
        to_varchar(ym)::varchar(6) as ym, --なし
        to_varchar(nykt)::varchar(1) as nykt, --なし
        sscd::varchar(6) as sscd, --なし
        tenpo::varchar(3) as tenpo, --なし
        hnbkbn::varchar(1) as hnbkbn, --なし
        ssaktncd::varchar(3) as ssaktncd, --なし
        to_varchar(tmcduo)::varchar(1) as tmcduo, --なし
        hkata::varchar(20) as hkata, --なし
        gaicd::varchar(4) as gaicd, --なし
        ucd::varchar(4) as ucd, --なし
        tire::varchar(3) as tire, --なし
        hanopt::varchar(80) as hanopt, --なし
        flno::varchar(7) as frmno, --なし
        shatai::varchar(17) as shatai, --なし
        split_part(shatai, '-', 1) as syadai_kt, --車台番号ハイフンの左
        tono_1_a::varchar(3) as tono1a, --なし
        tono_1_b::varchar(2) as tono1b, --なし
        tono_1_c::varchar(3) as tono1c, --なし
        tono_2::varchar(2) as tono2, --なし
        tono_3::varchar(6) as tono3, --なし
        shamei::varchar(2) as shamei, --なし
        sno::varchar(2) as sno, --なし
        bukbn::varchar(1) as bukbn, --なし
        ctlkata::varchar(16) as ctlkata, --なし
        basekata::varchar(20) as basekata, --なし
        tshameia::varchar(2) as tshameia, --なし
        tshameib::varchar(2) as tshameib, --なし
        tshameic::varchar(1) as tshameic, --なし
        tshameid::varchar(1) as tshameid, --なし
        mdlyear::varchar(6) as mdlyear, --なし
        sinkkbn::varchar(1) as sinkkbn, --なし
        engnmkbn::varchar(2) as engnmkbn, --なし
        kudo::varchar(1) as kudo, --なし
        mision::varchar(2) as mision, --なし
        sas::varchar(1) as sas, --なし
        doorsuu::varchar(1) as doorsuu, --なし
        grade::varchar(40) as grade, --なし
        sekisai::varchar(1) as sekisai, --なし
        roofkjy::varchar(1) as roofkjy, --なし
        hdkb::varchar(1) as hdkb, --なし
        youtokbn::varchar(1) as youtokbn, --なし
        tokb::varchar(1) as tokb, --なし
        chkb::varchar(1) as chkb, --なし
        to_varchar(kpkq)::varchar(2) as kpkq, --なし
        gykb::varchar(1) as gykb, --なし
        gukw_1::varchar(1) as gukw1, --なし
        gukw_2::varchar(1) as gukw2, --なし
        gukw_3::varchar(1) as gukw3, --なし
        gukw_4::varchar(1) as gukw4, --なし
        gukw_5::varchar(1) as gukw5, --なし
        sykb::varchar(1) as sykb, --なし
        reskbn::varchar(1) as reskbn, --なし
        tkkukbn::varchar(1) as tkkukbn, --なし
        crkb::varchar(1) as crkb, --なし
        conskbn::varchar(10) as conskbn, --なし
        to_varchar(ctkx)::varchar(6) as ctkx, --なし
        adxacd::varchar(2) as adxacd, --なし
        adxbcd::varchar(3) as adxbcd, --なし
        adxccd::varchar(4) as adxccd, --なし
        adxdcd::varchar(3) as adxdcd, --なし
        bosrk::varchar(8) as bosrk, --なし
        to_varchar(jucage)::varchar(2) as jucage, --なし
        sx::varchar(1) as sx, --なし
        vicfuken::varchar(2) as vicfuken, --なし
        vicsiku::varchar(3) as vicsiku, --なし
        viccyosn::varchar(4) as viccyosn, --なし
        ftdd::varchar(8) as ftdd, --なし
        hiytdd::varchar(8) as hiytdd, --なし
        toytdd::varchar(8) as toytdd, --なし
        todd::varchar(8) as todd, --なし
        nsqbdy::varchar(8) as nsqbdy, --なし
        nsdd::varchar(8) as nsdd, --なし
        ctumn::varchar(1) as ctumn, --なし
        _fivetran_synced::timestamp_ntz as ldts,  -- B層のldts
        rank() over (partition by dlrcd, cuno order by edano desc, ym desc,ldts desc) aggkey
    from {{source('fivetran_database_marketing', 'raw_ktrla07vzz0kiw0003') }}

    {% if is_incremental() %}
        where _fivetran_synced > (select max(ldts) from {{this}})
    {% endif %}
    
)
select * exclude(aggkey) from stg_shinsyameisai
where aggkey = 1
