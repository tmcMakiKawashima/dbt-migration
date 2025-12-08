{% snapshot scd_jfy1_ctrl_file_iotpf_kojoiot_subaru%}

{{
    config( 
        unique_key="concat_ws('-',
                    sfkey)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_jfy1_ctrl_file_iotpf_kojoiot_subaru') }} 

 {% endsnapshot %}