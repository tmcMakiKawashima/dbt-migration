{{
    config(
        materialized = 'incremental',
        unique_key = ['hinban', 'syusbetu'],
        incremental_strategy = 'merge'
    )
}}

with stg_cvk02siki_gsps as (
    select
        rtrim(hinban, ' 　')::varchar(15) as hinban, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        iff(rtrim(seppen, ' 　') = '', null, rtrim(seppen, ' 　'))::varchar(18) as seppen, -- 右blank,空値の場合はnull
        iff(rtrim(hinbansiki, ' 　') = '', null, rtrim(hinbansiki, ' 　'))::varchar(8) as hinbansiki, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (partition by hinban, syusbetu order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_tmjfvk08') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey, line_number) from stg_cvk02siki_gsps where aggkey = 1 order by hinban asc