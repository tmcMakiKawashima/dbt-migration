{% snapshot scd_oemseisan %}

{{
    config(
        unique_key="concat_ws('-',
                    syadai_kt,
                    frmno,
                    sketa)",
                    
        strategy='timestamp',
        updated_at='updatetime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_oemseisan') }}

{% endsnapshot %}