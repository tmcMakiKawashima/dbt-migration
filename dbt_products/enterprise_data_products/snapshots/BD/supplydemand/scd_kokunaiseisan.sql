{% snapshot scd_kokunaiseisan %}

{{
    config(
        unique_key="concat_ws('-',
                    syadai_kt,
                    frmno,
                    frmkbn,
                    shamei,
                    sno)",
                    
        strategy='timestamp',
        updated_at='updatetime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_kokunaiseisan') }}

{% endsnapshot %}