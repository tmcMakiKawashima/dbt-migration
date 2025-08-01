{{
    config (
        materialized = 'incremental',
        unique_key = 'vhc_key',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where vhc_key in (select vhc_key
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd003shihanho') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cubd003shihanho_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        kyoten_cd_finaldest::varchar(20) as kyoten_cd_finaldest, 
        kyoten_cd_plant::varchar(20) as kyoten_cd_plant, 
        kyoten_cd_genkyoten::varchar(20) as kyoten_cd_genkyoten, 
        hbtcd::varchar(5) as hbtcd, 
        odno::varchar(12) as odno, 
        chumonno::varchar(12) as chumonno, 
        kyaku_umu::varchar(1) as kyaku_umu, 
        businessoffice_cd::varchar(3) as businessoffice_cd, 
        frame_kbn::varchar(3) as frame_kbn, 
        frame_no::varchar(7) as frame_no, 
        vhc_yuko_kbn::varchar(1) as vhc_yuko_kbn, 
        latest_kosin_nitiji::varchar(12) as latest_kosin_nitiji, 
        tck_yotei_bi_haisya::varchar(8) as tck_yotei_bi_haisya, 
        tck_yotei_bi_annai::varchar(8) as tck_yotei_bi_annai, 
        okure_nissu_annai::varchar(3) as okure_nissu_annai, 
        tck_yotei_bi_latest::varchar(8) as tck_yotei_bi_latest, 
        noukikosin_sinsei::varchar(1) as noukikosin_sinsei, 
        noukikosin_siteinitiji::varchar(12) as noukikosin_siteinitiji, 
        noukikosin_jyokyo::varchar(1) as noukikosin_jyokyo, 
        noukikosin_kaisu::varchar(2) as noukikosin_kaisu, 
        tokkyu_flg::varchar(1) as tokkyu_flg, 
        vhc_sts_kbn::varchar(1) as vhc_sts_kbn, 
        yuso_cd_haisya::varchar(5) as yuso_cd_haisya, 
        yuso_cd_latest::varchar(5) as yuso_cd_latest, 
        seikansyamei_cd::varchar(2) as seikansyamei_cd, 
        ijyo_flg::varchar(1) as ijyo_flg, 
        osirase_info_flg::varchar(1) as osirase_info_flg, 
        lo_date_plan::varchar(8) as lo_date_plan, 
        naikosen_umu::varchar(1) as naikosen_umu, 
        tecs_sign::varchar(1) as tecs_sign, 
        sinten_yotei_bi::varchar(8) as sinten_yotei_bi, 
        sinten_kibo_bi::varchar(8) as sinten_kibo_bi, 
        sinten_seq::varchar(2) as sinten_seq, 
        disp_vhc_kbn::varchar(1) as disp_vhc_kbn, 
        ctrl_ktsk::varchar(20) as ctrl_ktsk, 
        kosyo_ktsk::varchar(20) as kosyo_ktsk, 
        syuken_jsk_nitiji::varchar(12) as syuken_jsk_nitiji, 
        lo_jsk_nitiji::varchar(12) as lo_jsk_nitiji, 
        ukewatasi_cd::varchar(5) as ukewatasi_cd, 
        noki_sanshutsu_nitiji::varchar(12) as noki_sanshutsu_nitiji, 
        ijyo_riyu_cd::varchar(3) as ijyo_riyu_cd, 
        bankai_kbn::varchar(1) as bankai_kbn, 
        tck_yotei_bi_annai_sai::varchar(8) as tck_yotei_bi_annai_sai, 
        taisho_vhc::varchar(1) as taisho_vhc, 
        tck_yotei_bi_chakou::varchar(8) as tck_yotei_bi_chakou, 
        inst_datetime::timestamp_ntz(9) as inst_datetime,
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime,
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd003shihanho') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cubd003shihanho_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}