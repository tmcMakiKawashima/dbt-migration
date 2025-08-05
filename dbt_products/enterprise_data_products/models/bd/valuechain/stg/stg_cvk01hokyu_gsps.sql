{{
    config(
        materialized = 'incremental',
        unique_key = ['hinban', 'syusbetu', 'seppenjun'],
        incremental_strategy = 'merge'
    )
}}

with stg_cvk01hokyu_gsps as (
    select
        rtrim(hinban, ' 　')::varchar(15) as hinban, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        try_cast(seppenjun as number(15)) as seppenjun,
        iff(rtrim(kerekijun, ' 　') = '', null, rtrim(kerekijun, ' 　'))::varchar(5) as kerekijun, -- 右blank,空値の場合はnull
        iff(rtrim(kara, ' 　') = '', null, rtrim(kara, ' 　'))::varchar(8) as kara, -- 右blank,空値の場合はnull
        iff(rtrim(made, ' 　') = '', null, rtrim(made, ' 　'))::varchar(8) as made, -- 右blank,空値の場合はnull
        iff(rtrim(motomade, ' 　') = '', null, rtrim(motomade, ' 　'))::varchar(8) as motomade, -- 右blank,空値の場合はnull
        iff(rtrim(seppen, ' 　') = '', null, rtrim(seppen, ' 　'))::varchar(18) as seppen, -- 右blank,空値の場合はnull
        iff(rtrim(hokyukbn, ' 　') = '', null, rtrim(hokyukbn, ' 　'))::varchar(2) as hokyukbn, -- 右blank,空値の場合はnull
        iff(rtrim(gokbn, ' 　') = '', null, rtrim(gokbn, ' 　'))::varchar(1) as gokbn, -- 右blank,空値の場合はnull
        iff(rtrim(hokyumukoflg, ' 　') = '', null, rtrim(hokyumukoflg, ' 　'))::varchar(1) as hokyumukoflg, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (partition by hinban, syusbetu, seppenjun order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_tmjfvk09') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey, line_number) from stg_cvk01hokyu_gsps 
where aggkey = 1 and seppenjun is not null
order by hinban asc