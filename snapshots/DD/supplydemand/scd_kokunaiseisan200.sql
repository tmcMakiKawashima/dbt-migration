{% snapshot scd_kokunaiseisan200 %}

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

select * from {{ ref('scd_kokunaiseisan200') }}

{% endsnapshot %}