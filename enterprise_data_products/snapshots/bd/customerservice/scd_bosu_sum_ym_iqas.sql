{% snapshot scd_bosu_sum_ym_iqas%}

{{
    config( 
        unique_key="concat_ws('-',
                    lo_year_month,
                    lo_year_month_date,
                    model_major_cls_code,
                    model_veh_code,
                    sms_veh_code,
                    katashiki_20,
                    eng_type,
                    tm_type,
                    dest_code,
                    reg_state_code,
                    region_cls,
                    export_cls,
                    endc_line_code,
                    eng_plnt_code,
                    production_area_cls,
                    vin_my,
                    pack_line_code,
                    pack_form,
                    brand_cls,
                    veh_plnt_code,
                    production_country_code,
                    lo_date,
                    frame_cls,
                    reg_country_code,
                    cmpnycode,
                    region_cls_new)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_bosu_sum_ym_iqas') }} 

 {% endsnapshot %}