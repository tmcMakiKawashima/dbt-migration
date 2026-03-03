{% snapshot scd_jfy1_sfh_history_iotpf%}

{{
    config( 
        unique_key="concat_ws('-',
                    sfkey,
                    line,
                    tp,
                    keycount)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jfy1_sfh_history_iotpf') }} 

 {% endsnapshot %}