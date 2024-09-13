{{ 
  config(
    materialized='incremental',
    unique_key = ['dlrcd','chumon'],
    incremental_strategy = 'merge'
  )
 }}

with stg_yohinhinbanmeisai as (
    select
        mntkbn::varchar(1) as mntkbn, --なし
        dlrcd::varchar(5) as dlrcd, --なし
        cuno::varchar(12) as chumon, --なし
        edano::varchar(2) as edano, --なし
        to_varchar(ym)::varchar(6) as ym, --なし
        to_varchar(tmcduo)::varchar(1) as tmcduo, --なし
        to_varchar(bukai)::varchar(1) as bukai, --なし
        bukbn::varchar(1) as bukbn, --なし
        hkata::varchar(30) as hkata, --なし
        gaicd::varchar(4) as gaicd, --なし
        ucd::varchar(4) as ucd, --なし
        mdlyear::varchar(6) as mdlyear, --なし
        sinkkbn::varchar(1) as sinkkbn, --なし
        grade::varchar(40) as grade, --なし
        to_varchar(hdkb)::varchar(1) as hdkb, --なし
        yokb::varchar(1) as yokb, --なし
        sx::varchar(1) as sx, --なし
        jucage::number(2) as jucage, --なし
        tshamei::varchar(6) as tshamei, --なし
        tshameia::varchar(2) as tshameia, --なし
        tshameib::varchar(2) as tshameib, --なし
        tshameic::varchar(1) as tshameic, --なし
        tshameid::varchar(1) as tshameid, --なし
        jkeidd::varchar(8) as jkeidd, --なし
        jcankedd::varchar(8) as jcankedd, --なし
        hanbkjdd::varchar(8) as hanbkjdd, --なし
        hbcnkjdd::varchar(8) as hbcnkjdd, --なし
        hinban_1::varchar(12) as hinban1, --なし
        kosu_1::number(2) as kosu1, --なし
        hinban_2::varchar(12) as hinban2, --なし
        kosu_2::number(2) as kosu2, --なし
        hinban_3::varchar(12) as hinban3, --なし
        kosu_3::number(2) as kosu3, --なし
        hinban_4::varchar(12) as hinban4, --なし
        kosu_4::number(2) as kosu4, --なし
        hinban_5::varchar(12) as hinban5, --なし
        kosu_5::number(2) as kosu5, --なし
        hinban_6::varchar(12) as hinban6, --なし
        kosu_6::number(2) as kosu6, --なし
        hinban_7::varchar(12) as hinban7, --なし
        kosu_7::number(2) as kosu7, --なし
        hinban_8::varchar(12) as hinban8, --なし
        kosu_8::number(2) as kosu8, --なし
        hinban_9::varchar(12) as hinban9, --なし
        kosu_9::number(2) as kosu9, --なし
        hinban_10::varchar(12) as hinban10, --なし
        kosu_10::number(2) as kosu10, --なし
        hinban_11::varchar(12) as hinban11, --なし
        kosu_11::number(2) as kosu11, --なし
        hinban_12::varchar(12) as hinban12, --なし
        kosu_12::number(2) as kosu12, --なし
        hinban_13::varchar(12) as hinban13, --なし
        kosu_13::number(2) as kosu13, --なし
        hinban_14::varchar(12) as hinban14, --なし
        kosu_14::number(2) as kosu14, --なし
        hinban_15::varchar(12) as hinban15, --なし
        kosu_15::number(2) as kosu15, --なし
        hinban_16::varchar(12) as hinban16, --なし
        kosu_16::number(2) as kosu16, --なし
        hinban_17::varchar(12) as hinban17, --なし
        kosu_17::number(2) as kosu17, --なし
        hinban_18::varchar(12) as hinban18, --なし
        kosu_18::number(2) as kosu18, --なし
        hinban_19::varchar(12) as hinban19, --なし
        kosu_19::number(2) as kosu19, --なし
        hinban_20::varchar(12) as hinban20, --なし
        kosu_20::number(2) as kosu20, --なし
        hinban_21::varchar(12) as hinban21, --なし
        kosu_21::number(2) as kosu21, --なし
        hinban_22::varchar(12) as hinban22, --なし
        kosu_22::number(2) as kosu22, --なし
        hinban_23::varchar(12) as hinban23, --なし
        kosu_23::number(2) as kosu23, --なし
        hinban_24::varchar(12) as hinban24, --なし
        kosu_24::number(2) as kosu24, --なし
        hinban_25::varchar(12) as hinban25, --なし
        kosu_25::number(2) as kosu25, --なし
        hinban_26::varchar(12) as hinban26, --なし
        kosu_26::number(2) as kosu26, --なし
        hinban_27::varchar(12) as hinban27, --なし
        kosu_27::number(2) as kosu27, --なし
        hinban_28::varchar(12) as hinban28, --なし
        kosu_28::number(2) as kosu28, --なし
        hinban_29::varchar(12) as hinban29, --なし
        kosu_29::number(2) as kosu29, --なし
        hinban_30::varchar(12) as hinban30, --なし
        kosu_30::number(2) as kosu30, --なし
        hinban_31::varchar(12) as hinban31, --なし
        kosu_31::number(2) as kosu31, --なし
        hinban_32::varchar(12) as hinban32, --なし
        kosu_32::number(2) as kosu32, --なし
        hinban_33::varchar(12) as hinban33, --なし
        kosu_33::number(2) as kosu33, --なし
        hinban_34::varchar(12) as hinban34, --なし
        kosu_34::number(2) as kosu34, --なし
        hinban_35::varchar(12) as hinban35, --なし
        kosu_35::number(2) as kosu35, --なし
        hinban_36::varchar(12) as hinban36, --なし
        kosu_36::number(2) as kosu36, --なし
        hinban_37::varchar(12) as hinban37, --なし
        kosu_37::number(2) as kosu37, --なし
        hinban_38::varchar(12) as hinban38, --なし
        kosu_38::number(2) as kosu38, --なし
        hinban_39::varchar(12) as hinban39, --なし
        kosu_39::number(2) as kosu39, --なし
        hinban_40::varchar(12) as hinban40, --なし
        kosu_40::number(2) as kosu40, --なし
        hinban_41::varchar(12) as hinban41, --なし
        kosu_41::number(2) as kosu41, --なし
        hinban_42::varchar(12) as hinban42, --なし
        kosu_42::number(2) as kosu42, --なし
        hinban_43::varchar(12) as hinban43, --なし
        kosu_43::number(2) as kosu43, --なし
        hinban_44::varchar(12) as hinban44, --なし
        kosu_44::number(2) as kosu44, --なし
        hinban_45::varchar(12) as hinban45, --なし
        kosu_45::number(2) as kosu45, --なし
        hinban_46::varchar(12) as hinban46, --なし
        kosu_46::number(2) as kosu46, --なし
        hinban_47::varchar(12) as hinban47, --なし
        kosu_47::number(2) as kosu47, --なし
        hinban_48::varchar(12) as hinban48, --なし
        kosu_48::number(2) as kosu48, --なし
        hinban_49::varchar(12) as hinban49, --なし
        kosu_49::number(2) as kosu49, --なし
        hinban_50::varchar(12) as hinban50, --なし
        kosu_50::number(2) as kosu50, --なし
        hinban_51::varchar(12) as hinban51, --なし
        kosu_51::number(2) as kosu51, --なし
        hinban_52::varchar(12) as hinban52, --なし
        kosu_52::number(2) as kosu52, --なし
        hinban_53::varchar(12) as hinban53, --なし
        kosu_53::number(2) as kosu53, --なし
        hinban_54::varchar(12) as hinban54, --なし
        kosu_54::number(2) as kosu54, --なし
        hinban_55::varchar(12) as hinban55, --なし
        kosu_55::number(2) as kosu55, --なし
        hinban_56::varchar(12) as hinban56, --なし
        kosu_56::number(2) as kosu56, --なし
        hinban_57::varchar(12) as hinban57, --なし
        kosu_57::number(2) as kosu57, --なし
        hinban_58::varchar(12) as hinban58, --なし
        kosu_58::number(2) as kosu58, --なし
        hinban_59::varchar(12) as hinban59, --なし
        kosu_59::number(2) as kosu59, --なし
        hinban_60::varchar(12) as hinban60, --なし
        kosu_60::number(2) as kosu60, --なし
        hinban_61::varchar(12) as hinban61, --なし
        kosu_61::number(2) as kosu61, --なし
        hinban_62::varchar(12) as hinban62, --なし
        kosu_62::number(2) as kosu62, --なし
        hinban_63::varchar(12) as hinban63, --なし
        kosu_63::number(2) as kosu63, --なし
        hinban_64::varchar(12) as hinban64, --なし
        kosu_64::number(2) as kosu64, --なし
        hinban_65::varchar(12) as hinban65, --なし
        kosu_65::number(2) as kosu65, --なし
        hinban_66::varchar(12) as hinban66, --なし
        kosu_66::number(2) as kosu66, --なし
        hinban_67::varchar(12) as hinban67, --なし
        kosu_67::number(2) as kosu67, --なし
        hinban_68::varchar(12) as hinban68, --なし
        kosu_68::number(2) as kosu68, --なし
        hinban_69::varchar(12) as hinban69, --なし
        kosu_69::number(2) as kosu69, --なし
        _fivetran_synced::timestamp as ldts, --timestamp型
        rank() over (partition by dlrcd, chumon order by edano desc, ym desc, ldts desc) aggkey
    from {{ source('fivetran_database_valuechain', 'raw_tc125yohinhinban') }}

{% if is_incremental() %}                                                                                                              -- ② 増分の取り方を指定
    where _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * exclude(aggkey)
from stg_yohinhinbanmeisai
where aggkey = 1