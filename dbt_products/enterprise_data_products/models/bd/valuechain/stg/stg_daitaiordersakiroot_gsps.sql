{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{ this }}
                where (daiohin, daiohinsbetu) in (select rtrim(daiohin, ' 　'), rtrim(daiohinsbetu, ' 　')
                from {{ ref('substr_tmjfvk06') }}
                where ldts > (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- daiohin, daiohinsbetu 単位で洗い替え

with stg_daitaiordersakiroot_gsps as (
    select
        rtrim(daiohin, ' 　')::varchar(15) as daiohin, -- 右blank
        rtrim(daiohinsbetu, ' 　')::varchar(2) as daiohinsbetu, -- 右blank
        rtrim(hantiiki, ' 　')::varchar(5) as hantiiki, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        rtrim(orderjtai1, ' 　')::varchar(7) as orderjtai1, -- 右blank
        rtrim(orderjtai2, ' 　')::varchar(7) as orderjtai2, -- 右blank
        rtrim(orderjtai3, ' 　')::varchar(7) as orderjtai3, -- 右blank
        rtrim(orderjtai4, ' 　')::varchar(7) as orderjtai4, -- 右blank
        rtrim(orderjtai5, ' 　')::varchar(7) as orderjtai5, -- 右blank
        iff(rtrim(made, ' 　') = '', null, rtrim(made, ' 　'))::varchar(8) as made, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts
    from {{ ref('substr_tmjfvk06') }}
)
select * from stg_daitaiordersakiroot_gsps

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}