{{
    config(
        materialized='incremental',
        unique_key = ['pno'],
        incremental_strategy = 'merge'
    )
}}

with stg_nonyult_atop as (
    select
        rtrim(hinban)::varchar(20) as pno,
        iff(rtrim(zaihikbn, ' 　') = '', null, rtrim(zaihikbn))::varchar(1) as stknstkcd,
        iff(rtrim(nonult3, ' 　') = '', null, to_decimal(nonult3))::number(3,0) as deliverylt,
        iff(rtrim(sakuseiymd, ' 　') = '', null, rtrim(sakuseiymd))::varchar(8) as linkfmprocdt,
        ldts::timestamp_ntz(9) as ldts,
        line_number,
        row_number() over (
          partition by pno
          order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla01vzz0kvp00q1')}}
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * exclude(line_number, aggkey) from stg_nonyult_atop
where aggkey = 1