{% snapshot scd_jm41_sfkey_history_iotpf %}

{{
    config( 
        unique_key="concat_ws('-',
                    sfkey)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jm41_sfkey_history_iotpf') }} 

 {% endsnapshot %}