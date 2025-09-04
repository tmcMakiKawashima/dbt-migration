{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{ this }}
                where (daiohin) in (select rtrim(daiohin, ' 　')
                from {{ ref('substr_tmjfvk10') }}
                where ldts > (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- daiohin 単位で洗い替え

with stg_daitai_gsps as (
    select
        rtrim(daiohin, ' 　')::varchar(15) as daiohin, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        try_cast(seppenjun as number(15)) as seppenjun,
        rtrim(dainhin, ' 　')::varchar(15) as dainhin, -- 右blank
        try_cast(kerekijun as number(5)) as kerekijun,
        iff(rtrim(kara, ' 　') = '', null, rtrim(kara, ' 　'))::varchar(8) as kara, -- 右blank,空値の場合はnull
        iff(rtrim(made, ' 　') = '', null, rtrim(made, ' 　'))::varchar(8) as made, -- 右blank,空値の場合はnull
        iff(rtrim(motomade, ' 　') = '', null, rtrim(motomade, ' 　'))::varchar(8) as motomade, -- 右blank,空値の場合はnull
        iff(rtrim(daitype, ' 　') = '', null, rtrim(daitype, ' 　'))::varchar(2) as daitype, -- 右blank,空値の場合はnull
        iff(rtrim(daikbn, ' 　') = '', null, rtrim(daikbn, ' 　'))::varchar(2) as daikbn, -- 右blank,空値の場合はnull
        iff(rtrim(daikosu, ' 　') = '', null, rtrim(daikosu, ' 　'))::varchar(2) as daikosu, -- 右blank,空値の場合はnull
        iff(rtrim(daicom, ' 　') = '', null, rtrim(daicom, ' 　'))::varchar(30) as daicom, -- 右blank,空値の場合はnull
        iff(rtrim(mainhin, ' 　') = '', null, rtrim(mainhin, ' 　'))::varchar(15) as mainhin, -- 右blank,空値の場合はnull
        iff(rtrim(setm, ' 　') = '', null, rtrim(setm, ' 　'))::varchar(2) as setm, -- 右blank,空値の場合はnull
        iff(rtrim(sentakukbn, ' 　') = '', null, rtrim(sentakukbn, ' 　'))::varchar(2) as sentakukbn, -- 右blank,空値の場合はnull
        iff(rtrim(seppen, ' 　') = '', null, rtrim(seppen, ' 　'))::varchar(18) as seppen, -- 右blank,空値の場合はnull
        iff(rtrim(kosinseppen, ' 　') = '', null, rtrim(kosinseppen, ' 　'))::varchar(18) as kosinseppen, -- 右blank,空値の場合はnull
        iff(rtrim(hokyumukoflg, ' 　') = '', null, rtrim(hokyumukoflg, ' 　'))::varchar(1) as hokyumukoflg, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts
    from {{ ref('substr_tmjfvk10') }}

    {% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_daitai_gsps
where seppenjun is not null and kerekijun is not null