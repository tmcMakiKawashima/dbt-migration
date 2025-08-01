{{
    config (
        materialized = 'incremental',
        unique_key = 'urn',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where urn in (select urn
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd007yusyutuho') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cubd007yusyutuho_vlc as (
    select
        urn::varchar(10) as urn, 
        vhc_key::varchar(15) as vhc_key, 
        kyoten_cd_finaldest::varchar(20) as kyoten_cd_finaldest, 
        kyoten_cd_genkyoten::varchar(20) as kyoten_cd_genkyoten, 
        kyoten_cd_plant::varchar(20) as kyoten_cd_plant, 
        maxkoro_cd_d2::varchar(2) as maxkoro_cd_d2, 
        minkoro_cd_d2::varchar(2) as minkoro_cd_d2, 
        kakutei_hosiki_d2::varchar(1) as kakutei_hosiki_d2, 
        shipper_cd_d2::varchar(5) as shipper_cd_d2, 
        haisen_knr_no_d2::varchar(4) as haisen_knr_no_d2, 
        maxkoro_cd_latest::varchar(2) as maxkoro_cd_latest, 
        minkoro_cd_latest::varchar(2) as minkoro_cd_latest, 
        kakutei_hosiki_latest::varchar(1) as kakutei_hosiki_latest, 
        shipper_cd_latest::varchar(5) as shipper_cd_latest, 
        haisen_knr_no_latest::varchar(4) as haisen_knr_no_latest, 
        frame_kbn::varchar(3) as frame_kbn, 
        frame_no::varchar(8) as frame_no, 
        edno::varchar(6) as edno, 
        dsno::varchar(4) as dsno, 
        vhc_yuko_kbn::varchar(1) as vhc_yuko_kbn, 
        latest_kosin_nitiji::varchar(12) as latest_kosin_nitiji, 
        tck_yotei_nitiji_d2::varchar(12) as tck_yotei_nitiji_d2, 
        okure_time_d2::varchar(4) as okure_time_d2, 
        tck_yotei_nitiji_haisya::varchar(12) as tck_yotei_nitiji_haisya, 
        okure_time_haisya::varchar(4) as okure_time_haisya, 
        tck_yotei_nitiji_latest::varchar(12) as tck_yotei_nitiji_latest, 
        tokkyu_flg::varchar(1) as tokkyu_flg, 
        vhc_sts_kbn::varchar(1) as vhc_sts_kbn, 
        juten_knr_flg::varchar(1) as juten_knr_flg, 
        smkc_cd::varchar(3) as smkc_cd, 
        juchu_cd::varchar(5) as juchu_cd, 
        niagekou_cd_cosmos::varchar(5) as niagekou_cd_cosmos, 
        senpaku_cd_latest::varchar(5) as senpaku_cd_latest, 
        funakaku_yotei_nitiji::varchar(12) as funakaku_yotei_nitiji, 
        funakaisi_yotei_nitiji::varchar(12) as funakaisi_yotei_nitiji, 
        ijyo_flg::varchar(1) as ijyo_flg, 
        naikosen_umu::varchar(1) as naikosen_umu, 
        niji_siji_umu::varchar(1) as niji_siji_umu, 
        disp_vhc_kbn::varchar(1) as disp_vhc_kbn, 
        ctrl_ktsk::varchar(20) as ctrl_ktsk, 
        kosyo_ktsk::varchar(20) as kosyo_ktsk, 
        syuken_jsk_nitiji::varchar(12) as syuken_jsk_nitiji, 
        lo_jsk_nitiji::varchar(12) as lo_jsk_nitiji, 
        ukewatasi_cd::varchar(5) as ukewatasi_cd, 
        okiba::varchar(6) as okiba, 
        seikansyamei_cd::varchar(2) as seikansyamei_cd, 
        inst_datetime::timestamp_ntz(9) as inst_datetime,
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime,
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd007yusyutuho') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cubd007yusyutuho_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}