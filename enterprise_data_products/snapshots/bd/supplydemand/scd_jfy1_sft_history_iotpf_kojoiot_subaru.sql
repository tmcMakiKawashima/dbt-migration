{% snapshot scd_jfy1_sft_history_iotpf_kojoiot_subaru%}

{{
    config( 
        unique_key="concat_ws('-',
                    sfkey)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jfy1_sft_history_iotpf_kojoiot_subaru') }} 

 {% endsnapshot %}