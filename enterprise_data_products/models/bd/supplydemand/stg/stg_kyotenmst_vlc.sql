{{
    config (
        materialized = 'incremental',
        unique_key = ['kyoten_cd', 'tkiy_k'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (kyoten_cd, tkiy_k) in (select kyoten_cd, tkiy_k
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc101kyoten') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_kyotenmst_vlc as (
    select
        kyoten_cd::varchar(20) as kyoten_cd, 
        tkiy_k::varchar(12) as tkiy_k, 
        tkiy_m::varchar(12) as tkiy_m, 
        mng_company_cd::varchar(5) as mng_company_cd, 
        mng_country_cd::varchar(3) as mng_country_cd, 
        kyoten_kbn::varchar(1) as kyoten_kbn, 
        saiban_cd::varchar(7) as saiban_cd, 
        yobi::varchar(4) as yobi, 
        kyoten_kino::varchar(1) as kyoten_kino, 
        rtrim(kyoten_nm, ' 　')::varchar(90) as kyoten_nm, 
        kyoten_nm_en::varchar(60) as kyoten_nm_en, 
        rtrim(hyouji_nm, ' 　')::varchar(24) as hyouji_nm, 
        hyouji_nm_en::varchar(30) as hyouji_nm_en, 
        district_cd::varchar(3) as district_cd, 
        syuyo_kyoten_flg::varchar(1) as syuyo_kyoten_flg, 
        inst_datetime::timestamp_ntz(9) as inst_datetime, 
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime, 
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc101kyoten') }}
    where _fivetran_deleted = 'false'
)
select * from stg_kyotenmst_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}