{% snapshot scd_haisya %}

{{
    config(
        unique_key="concat_ws('-',
                    syadai_kt,
                    frmno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_haisya') }}

{% endsnapshot %}