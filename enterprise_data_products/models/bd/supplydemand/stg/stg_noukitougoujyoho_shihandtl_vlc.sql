{{
    config (
        materialized = 'incremental',
        unique_key = 'vhc_key',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where vhc_key in (select vhc_key
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd002shihandtl') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_noukitougoujyoho_shihandtl_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        prdct_year::varchar(4) as prdct_year, 
        idno::varchar(10) as idno, 
        tenpo_yotei_bi::varchar(8) as tenpo_yotei_bi, 
        tenpo_kibo_bi::varchar(8) as tenpo_kibo_bi, 
        okure_nissu_sinten::varchar(3) as okure_nissu_sinten, 
        chakko_yotei_nitiji::varchar(12) as chakko_yotei_nitiji, 
        chakko_jsk_nitiji::varchar(12) as chakko_jsk_nitiji, 
        tck_jsk_bi::varchar(8) as tck_jsk_bi, 
        nyumon_jsk_nitiji::varchar(12) as nyumon_jsk_nitiji, 
        syuken_yotei_nitiji::varchar(12) as syuken_yotei_nitiji, 
        haisya_yotei_nitiji::varchar(12) as haisya_yotei_nitiji, 
        haisya_jsk_nitiji::varchar(12) as haisya_jsk_nitiji, 
        kyoten_cd_syukka::varchar(20) as kyoten_cd_syukka, 
        kaso_maker_cd::varchar(5) as kaso_maker_cd, 
        kyoten_cd_kasomaker::varchar(20) as kyoten_cd_kasomaker, 
        yoteihokanti_cd::varchar(5) as yoteihokanti_cd, 
        kyoten_cd_hokan::varchar(20) as kyoten_cd_hokan, 
        hbtcd_ai21::varchar(5) as hbtcd_ai21, 
        chakusen_yotei_bi::varchar(8) as chakusen_yotei_bi, 
        chakusen_jsk_bi::varchar(8) as chakusen_jsk_bi, 
        gaiban_color_cd::varchar(4) as gaiban_color_cd, 
        sales_ktsk::varchar(20) as sales_ktsk, 
        kyoten_kaisu::varchar(1) as kyoten_kaisu, 
        tenpo_cd::varchar(3) as tenpo_cd, 
        huriate_bi::varchar(8) as huriate_bi,  
        inst_datetime::timestamp_ntz(9) as inst_datetime, 
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime, 
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd002shihandtl') }}
    where _fivetran_deleted = 'false'
)
select * from stg_noukitougoujyoho_shihandtl_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}