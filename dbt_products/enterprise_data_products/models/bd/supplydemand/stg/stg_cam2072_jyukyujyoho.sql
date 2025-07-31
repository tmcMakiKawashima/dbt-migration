{{
    config (
        materialized = 'incremental',
        unique_key = ['segmei', 'dlrcd', 'odno', 'ojyy'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (segmei, dlrcd, odno, ojyy) in (select segmei, dlrcd, odno, ojyy
                from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp01sam202', 'raw_cam2072') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cam2072_jyukyujyoho as (
    select
        dum1::varchar(1) as dum1, 
        segmei::varchar(8) as segmei, 
        dlrcd::varchar(5) as dlrcd, 
        odno::varchar(12) as odno, 
        dum2::varchar(104) as dum2, 
        odno2::varchar(12) as odno2, 
        jrdate::varchar(8) as jrdate, 
        kndate::varchar(8) as kndate, 
        kydate::varchar(8) as kydate, 
        hydate::varchar(8) as hydate, 
        tydate::varchar(8) as tydate, 
        nsdate::varchar(8) as nsdate, 
        frsign::varchar(1) as frsign, 
        nfuyo::varchar(1) as nfuyo, 
        ukecd::varchar(1) as ukecd, 
        kfsign::varchar(1) as kfsign, 
        vltsofu::varchar(1) as vltsofu, 
        wax::varchar(1) as wax, 
        zaikosk::varchar(5) as zaikosk, 
        yusosk1::varchar(8) as yusosk1, 
        bukbn::varchar(1) as bukbn, 
        nhsign::varchar(1) as nhsign, 
        shamei::varchar(2) as shamei, 
        sno::varchar(2) as sno, 
        ojyy::varchar(4) as ojyy, 
        dum3::varchar(1) as dum3, 
        create_user::varchar(15) as create_user, 
        create_date::timestamp_ntz(9) as create_date,
        update_user::varchar(15) as update_user, 
        update_date::timestamp_ntz(9) as update_date,
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp01sam202', 'raw_cam2072') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cam2072_jyukyujyoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}