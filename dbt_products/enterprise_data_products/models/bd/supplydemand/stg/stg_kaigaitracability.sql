{{
    config (
        materialized = 'incremental',
        unique_key = [
            'syadai_kt',
            'frmno',
            'wmi',
            'vds',
            'mdlyr',
            'vin_vds_cd',
            'lok_y',
            'msgno'
            ],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (syadai_kt, frmno, wmi, vds, mdlyr, vin_vds_cd, lok_y, msgno)
                in (select syadai_kt, frmno, wmi, vds, mdlyr, vin_vds_cd, lok_y, msgno
                from {{ ref('substr_da5a214a') }}
                where mtkbn = 'D'
                and ldts >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- MT区分が'D'に更新されたレコードを削除

with stg_kaigaitracability as (
    select
        mtkbn::varchar(1) as mtkbn, 
        lok_y4::varchar(1) as lok_y4, 
        syadai_kt::varchar(9) as syadai_kt, 
        frmno::varchar(7) as frmno, 
        wmi::varchar(3) as wmi, 
        vds::varchar(6) as vds, 
        mdlyr::varchar(1) as mdlyr, 
        vin_vds_cd::varchar(1) as vin_vds_cd, 
        lok_y::varchar(4) as lok_y, 
        lok_m::varchar(2) as lok_m, 
        msgno::varchar(4) as msgno, 
        itemcontent::varchar(30) as itemcontent, 
        createuser::varchar(13) as createuser, 
        try_to_timestamp_ntz(createtime, 'yyyy/mm/dd hh24:mi:ss.ff9') as createtime, -- timestamp
        updateuser::varchar(13) as updateuser, 
        try_to_timestamp_ntz(updatetime, 'yyyy/mm/dd hh24:mi:ss.ff9') as updatetime, -- timestamp
        ldts,
        line_number,
        rank() over(
                partition by
                    syadai_kt,
                    frmno,
                    wmi,
                    vds,
                    mdlyr,
                    vin_vds_cd,
                    lok_y,
                    msgno
                order by ldts desc, line_number desc
            ) aggkey
        from {{ref('substr_da5a214a')}}

        {% if is_incremental() %}
            where ldts > (select max(ldts) from {{ this }})
        {% endif %}

)
select * exclude(mtkbn, aggkey, line_number) from stg_kaigaitracability where aggkey = 1 and mtkbn = 'C'