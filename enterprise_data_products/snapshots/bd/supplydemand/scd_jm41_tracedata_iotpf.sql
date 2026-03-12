{% snapshot scd_jm41_tracedata_iotpf %}

{{
    config( 
        unique_key="concat_ws('-',
                    data_id,
                    pro_key_cd,
                    trace_tag_cd,
                    value)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jm41_tracedata_iotpf') }}
{% endsnapshot %}