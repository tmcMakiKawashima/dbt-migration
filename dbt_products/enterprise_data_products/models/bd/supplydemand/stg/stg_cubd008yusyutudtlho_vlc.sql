{{
    config (
        materialized = 'incremental',
        unique_key = 'urn',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where urn in (select urn
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd008yusyutudtlho') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cubd008yusyutudtlho_vlc as (
    select
        urn::varchar(10) as urn, 
        vhc_key::varchar(15) as vhc_key, 
        vin::varchar(17) as vin, 
        prdct_year::varchar(4) as prdct_year, 
        idno::varchar(10) as idno, 
        fd_cd::varchar(5) as fd_cd, 
        senpaku_cd_d2::varchar(5) as senpaku_cd_d2, 
        funakan_yotei_nitiji::varchar(12) as funakan_yotei_nitiji, 
        funakaku_jsk_nitiji::varchar(12) as funakaku_jsk_nitiji, 
        funakaisi_jsk_nitiji::varchar(12) as funakaisi_jsk_nitiji, 
        funakan_jsk_nitiji::varchar(12) as funakan_jsk_nitiji, 
        chakko_yotei_nitiji::varchar(12) as chakko_yotei_nitiji, 
        chakko_jsk_nitiji::varchar(12) as chakko_jsk_nitiji, 
        tck_yotei_nitiji_chakko::varchar(12) as tck_yotei_nitiji_chakko, 
        tck_jsk_nitiji::varchar(12) as tck_jsk_nitiji, 
        hunaju_knr_cd::varchar(1) as hunaju_knr_cd, 
        nyumon_jsk_nitiji::varchar(12) as nyumon_jsk_nitiji, 
        dest_cd::varchar(5) as dest_cd, 
        syuken_yotei_nitiji::varchar(12) as syuken_yotei_nitiji, 
        haisya_yotei_nitiji::varchar(12) as haisya_yotei_nitiji, 
        haisya_jsk_nitiji::varchar(12) as haisya_jsk_nitiji, 
        kyoten_cd_syukka::varchar(20) as kyoten_cd_syukka, 
        chakusen_yotei_bi::varchar(8) as chakusen_yotei_bi, 
        chakusen_jsk_bi::varchar(8) as chakusen_jsk_bi, 
        kaso_umu::varchar(1) as kaso_umu, 
        opt_umu::varchar(1) as opt_umu, 
        gaiban_color_cd::varchar(4) as gaiban_color_cd, 
        hozei_um::varchar(1) as hozei_um, 
        lo_date_plan::varchar(8) as lo_date_plan, 
        kyoten_kaisu::varchar(1) as kyoten_kaisu, 
        inst_datetime::timestamp_ntz(9) as inst_datetime,
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime,
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubd008yusyutudtlho') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cubd008yusyutudtlho_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}