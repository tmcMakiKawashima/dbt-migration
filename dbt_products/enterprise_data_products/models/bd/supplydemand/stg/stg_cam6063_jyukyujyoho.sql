{{
    config (
        materialized = 'incremental',
        unique_key = ['segmei', 'renkey_hkata', 'renkry_sedai', 'aply_dt_kara'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (segmei, renkey_hkata, renkry_sedai, aply_dt_kara) in (select segmei, renkey_hkata, renkry_sedai, aply_dt_kara
                from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp02sam202', 'raw_cam6063') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cam6063_jyukyujyoho as (
    select
        segmei::varchar(8) as segmei, 
        renkey_hkata::varchar(20) as renkey_hkata, 
        renkry_sedai::varchar(1) as renkry_sedai, 
        hkata::varchar(20) as hkata, 
        sedai::varchar(1) as sedai, 
        jkkyy::varchar(4) as jkkyy, 
        jkkmm::varchar(2) as jkkmm, 
        jkkdd::varchar(2) as jkkdd, 
        jkmyy::varchar(4) as jkmyy, 
        jkmmm::varchar(2) as jkmmm, 
        jkmdd::varchar(2) as jkmdd, 
        dkkyy::varchar(4) as dkkyy, 
        dkkmm::varchar(2) as dkkmm, 
        dkkdd::varchar(2) as dkkdd, 
        dkmyy::varchar(4) as dkmyy, 
        dkmmm::varchar(2) as dkmmm, 
        dkmdd::varchar(2) as dkmdd, 
        syamei::varchar(2) as syamei, 
        sno::varchar(2) as sno, 
        odt::varchar(1) as odt, 
        katacd::varchar(5) as katacd, 
        bkata::varchar(20) as bkata, 
        ckata::varchar(20) as ckata, 
        fix::varchar(1) as fix, 
        seikbn1::varchar(1) as seikbn1, 
        seijbn1::varchar(1) as seijbn1, 
        seiyk1::varchar(5) as seiyk1, 
        seibkbn1::varchar(1) as seibkbn1, 
        seikbn2::varchar(1) as seikbn2, 
        seijbn2::varchar(1) as seijbn2, 
        seiyk2::varchar(5) as seiyk2, 
        seibkbn2::varchar(1) as seibkbn2, 
        seikbn3::varchar(1) as seikbn3, 
        seijbn3::varchar(1) as seijbn3, 
        seiyk3::varchar(5) as seiyk3, 
        seibkbn3::varchar(1) as seibkbn3, 
        seikbn4::varchar(1) as seikbn4, 
        seijbn4::varchar(1) as seijbn4, 
        seiyk4::varchar(5) as seiyk4, 
        seibkbn4::varchar(1) as seibkbn4, 
        seikbn5::varchar(1) as seikbn5, 
        seijbn5::varchar(1) as seijbn5, 
        seiyk5::varchar(5) as seiyk5, 
        seibkbn5::varchar(1) as seibkbn5, 
        seikbn6::varchar(1) as seikbn6, 
        seijbn6::varchar(1) as seijbn6, 
        seiyk6::varchar(5) as seiyk6, 
        seibkbn6::varchar(1) as seibkbn6, 
        seikbn7::varchar(1) as seikbn7, 
        seijbn7::varchar(1) as seijbn7, 
        seiyk7::varchar(5) as seiyk7, 
        seibkbn7::varchar(1) as seibkbn7, 
        seikbn8::varchar(1) as seikbn8, 
        seijbn8::varchar(1) as seijbn8, 
        seiyk8::varchar(5) as seiyk8, 
        seibkbn8::varchar(1) as seibkbn8, 
        seikbn9::varchar(1) as seikbn9, 
        seijbn9::varchar(1) as seijbn9, 
        seiyk9::varchar(5) as seiyk9, 
        seibkbn9::varchar(1) as seibkbn9, 
        seikbn10::varchar(1) as seikbn10, 
        seijbn10::varchar(1) as seijbn10, 
        seiyk10::varchar(5) as seiyk10, 
        seibkbn10::varchar(1) as seibkbn10, 
        tecs::varchar(1) as tecs, 
        kmaker::varchar(5) as kmaker, 
        hassou::varchar(1) as hassou, 
        sofu::varchar(1) as sofu, 
        lflg::varchar(1) as lflg, 
        aply_dt_kara::varchar(8) as aply_dt_kara, 
        aply_dt_made::varchar(8) as aply_dt_made, 
        create_user::varchar(15) as create_user, 
        create_date::timestamp_ntz(9) as create_date,
        update_user::varchar(15) as update_user, 
        update_date::timestamp_ntz(9) as update_date,
        dum1::varchar(1) as dum1, 
        dum2::varchar(100) as dum2, 
        dum3::varchar(11) as dum3, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp02sam202', 'raw_cam6063') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cam6063_jyukyujyoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}