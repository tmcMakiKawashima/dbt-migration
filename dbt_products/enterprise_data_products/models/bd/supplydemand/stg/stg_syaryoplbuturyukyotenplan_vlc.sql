{{
    config (
        materialized = 'incremental',
        unique_key = ['vhc_key', 'plan_section', 'kyoten_cd', 'kyoten_kaisu'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (vhc_key, plan_section, kyoten_cd, kyoten_kaisu) in (select vhc_key, plan_section, kyoten_cd, kyoten_kaisu
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc025logkyotenplan') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_syaryoplbuturyukyotenplan_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        plan_section::varchar(2) as plan_section, 
        kyoten_cd::varchar(20) as kyoten_cd, 
        kyoten_kaisu::varchar(1) as kyoten_kaisu, 
        tp_kbn::varchar(2) as tp_kbn, 
        rootseq_no::varchar(3) as rootseq_no, 
        final_dest_flg::varchar(1) as final_dest_flg, 
        ship_final_dest_sign::varchar(1) as ship_final_dest_sign, 
        prdct_line::varchar(1) as prdct_line, 
        in_datetime_plan::varchar(12) as in_datetime_plan, 
        out_datetime_plan::varchar(12) as out_datetime_plan, 
        fst_in_datetime_plan::varchar(12) as fst_in_datetime_plan, 
        fst_out_datetime_plan::varchar(12) as fst_out_datetime_plan, 
        lst_in_datetime_plan::varchar(12) as lst_in_datetime_plan, 
        lst_out_datetime_plan::varchar(12) as lst_out_datetime_plan, 
        appointed_date::varchar(12) as appointed_date, 
        appointed_date_update::varchar(12) as appointed_date_update, 
        recover_line::varchar(12) as recover_line, 
        new_hope::varchar(12) as new_hope, 
        inst_datetime::timestamp_ntz(9) as inst_datetime, 
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime, 
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc025logkyotenplan') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syaryoplbuturyukyotenplan_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}