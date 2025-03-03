{{
    config (
        materialized = 'incremental',
        unique_key = ['syadai_kt', 'frmno'],
        incremental_strategy = 'merge'
    )
}}

with stg_haisya as (
    select
        mtkbn::varchar(1) as mtkbn,
        syadai_kt::varchar(6) as syadai_kt,
        frmno::varchar(7) as frmno,
        hnbaitncd::varchar(5) as hnbaitncd,
        haisya_y::varchar(4) as	haisya_y,
        haisya_m::varchar(2) as	haisya_m,
        haisya_d::varchar(2) as	haisya_d,
        createuser::varchar(13) as createuser,
        try_to_timestamp_ntz(createtime, 'yyyy/mm/dd hh24:mi:ss.ff9') as createtime, -- timestamp型
        updateuser::varchar(13) as updateuser,
        try_to_timestamp_ntz(updatetime, 'yyyy/mm/dd hh24:mi:ss.ff9') as updatetime, -- timestamp型
        ldts,
        rank() over (partition by syadai_kt, frmno order by ldts desc) aggkey
    from {{ ref('substr_da5a219a') }}

        {% if is_incremental() %}
            where ldts > (select max(ldts) from {{ this }})
        {% endif %}

)
select * exclude(mtkbn, aggkey) from stg_haisya where aggkey = 1 and mtkbn = 'C'