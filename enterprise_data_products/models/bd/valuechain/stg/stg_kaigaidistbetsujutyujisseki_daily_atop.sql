{{
    config(
        materialized='incremental',
        incremental_strategy = 'append'
    )
}}
with stg_kaigaidistbetsujutyujisseki_daily_atop as (
    select
        iff(rtrim(mntkbn, ' 　') = '', null, rtrim(mntkbn, ' 　'))::varchar(1) as mntkbn,
        iff(rtrim(hinban, ' 　') = '', null, rtrim(hinban, ' 　'))::varchar(20) as hinban,
        iff(rtrim(dlrcd, ' 　') = '', null, rtrim(dlrcd, ' 　'))::varchar(7) as dlrcd,
        iff(rtrim(odrzok, ' 　') = '', null, rtrim(odrzok, ' 　'))::varchar(1) as odrzok,
        iff(rtrim(keikakuodrkbn, ' 　') = '', null, rtrim(keikakuodrkbn, ' 　'))::varchar(1) as keikakuodrkbn,
        iff(rtrim(odrno, ' 　') = '', null, rtrim(odrno, ' 　'))::varchar(8) as odrno,
        iff(rtrim(yusokbn, ' 　') = '', null, rtrim(yusokbn, ' 　'))::varchar(1) as yusokbn,
        iff(rtrim(juchuymd, ' 　') = '', null, to_date(juchuymd, 'yyyymmdd'))::date as juchuymd,
        iff(rtrim(juchusu7, ' 　') = '', null, to_decimal(juchusu7))::number(7,0) as juchusu7,
        iff(rtrim(hind5, ' 　') = '', null, to_decimal(hind5))::number(5,0) as hind5,
        ldts::timestamp_ntz(9) as ldts,
    from {{ref('substr_ktrla01vzz0kvp00q7')}}
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select *  from stg_kaigaidistbetsujutyujisseki_daily_atop