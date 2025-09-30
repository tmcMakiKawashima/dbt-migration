{{
    config(
        materialized='incremental',
        incremental_strategy = 'append'
    )
}}

with stg_zaiko_file_atop as (
    select
        iff(rtrim(hinban, ' 　') = '', null, rtrim(hinban, ' 　'))::varchar(20) as hinban,
        iff(rtrim(kaknoukbn, ' 　') = '', null, rtrim(kaknoukbn, ' 　'))::varchar(1) as kaknoukbn,
        iff(rtrim(zaikomssign||zaikosu, ' 　') = '', null, to_decimal(zaikomssign||zaikosu))::number(7,0) as zaikosu,
        iff(rtrim(jcukzmssign||jknsu, ' 　') = '', null, to_decimal(jcukzmssign||jknsu))::number(7,0) as jknsu,
        iff(rtrim(ksyuzsu, ' 　') = '', null, to_decimal(ksyuzsu))::number(9,0) as ksyuzsu,
        iff(rtrim(tknkruimssign||tknkruisu, ' 　') = '', null, to_decimal(tknkruimssign||tknkruisu))::number(9,0) as tknkruisu,
        iff(rtrim(tkskruimssign||tkskruisu, ' 　') = '', null, to_decimal(tkskruimssign||tkskruisu))::number(9,0) as tkskruisu,
        iff(rtrim(nsksutmssign||nsksutsu, ' 　') = '', null, to_decimal(nsksutmssign||nsksutsu))::number(7,0) as nsksutsu,
        iff(rtrim(snttsmssign||snttssu, ' 　') = '', null, to_decimal(snttsmssign||snttssu))::number(7,0) as snttssu,
        iff(rtrim(torsaimssign||torsaisu, ' 　') = '', null, to_decimal(torsaimssign||torsaisu))::number(7,0) as torsaisu,
        iff(rtrim(kpksutmssign||kpksutsu, ' 　') = '', null, to_decimal(kpksutmssign||kpksutsu))::number(7,0) as kpksutsu,
        iff(rtrim(skdmssign||skdsu, ' 　') = '', null, to_decimal(skdmssign||skdsu))::number(7,0) as skdsu,
        iff(rtrim(jcukztsruimsign||jcukztsruisu, ' 　') = '', null, to_decimal(jcukztsruimsign||jcukztsruisu))::number(7,0) as jcukztsruisu,
        iff(rtrim(mtuserid, ' 　') = '', null, rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(rtrim(mttime, ' 　') = '', null, to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff6'))::timestamp_ntz(9) as mttime,
        ldts::timestamp_ntz(9) as ldts,
    from {{ref('substr_ktrla01vzz0kvn00em')}}
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * from stg_zaiko_file_atop