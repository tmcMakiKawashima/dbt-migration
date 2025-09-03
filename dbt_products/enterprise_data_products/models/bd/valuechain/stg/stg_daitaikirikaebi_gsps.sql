{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{ this }}
                where (daiohin) in (select rtrim(daiohin, ' 　')
                from {{ ref('substr_tmjfvk07') }}
                where ldts > (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- daiohin 単位で洗い替え

with stg_daitaikirikaebi_gsps as (
    select
        rtrim(daiohin, ' 　')::varchar(15) as daiohin, -- 右blank
        rtrim(orderjtai, ' 　')::varchar(7) as orderjtai, -- 右blank
        rtrim(hantiiki, ' 　')::varchar(5) as hantiiki, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        iff(rtrim(daikiriymdkm, ' 　') = '', null, rtrim(daikiriymdkm, ' 　'))::varchar(1) as daikiriymdkm, -- 右blank,空値の場合はnull
        iff(rtrim(haisincreymd, ' 　') = '', null, rtrim(haisincreymd, ' 　'))::varchar(8) as haisincreymd, -- 右blank,空値の場合はnull
        iff(rtrim(daikiriyoteiymd, ' 　') = '', null, rtrim(daikiriyoteiymd, ' 　'))::varchar(8) as daikiriyoteiymd, -- 右blank,空値の場合はnull
        iff(rtrim(daikiriymd, ' 　') = '', null, rtrim(daikiriymd, ' 　'))::varchar(8) as daikiriymd, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts
    from {{ ref('substr_tmjfvk07') }}
)
select * from stg_daitaikirikaebi_gsps

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}