{{
    config(
        materialized = 'incremental',
        unique_key = ['hinban', 'hinbansbetu', 'syusbetu'],
        incremental_strategy = 'merge'
    )
}}

with stg_hinbanjyohohinmei_gsps as (
    select
        rtrim(hinban, ' 　')::varchar(15) as hinban, -- 右blank
        rtrim(hinbansbetu, ' 　')::varchar(2) as hinbansbetu, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        iff(rtrim(hasseigen, ' 　') = '', null, rtrim(hasseigen, ' 　'))::varchar(2) as hasseigen, -- 右blank,空値の場合はnull
        iff(rtrim(hinmei, ' 　') = '', null, rtrim(hinmei, ' 　'))::varchar(40) as hinmei, -- 右blank,空値の場合はnull
        iff(rtrim(hinbanhyojikbn, ' 　') = '', null, rtrim(hinbanhyojikbn, ' 　'))::varchar(1) as hinbanhyojikbn, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (partition by hinban, hinbansbetu, syusbetu order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_tmjfvk04') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey, line_number) from stg_hinbanjyohohinmei_gsps where aggkey = 1 order by hinban asc