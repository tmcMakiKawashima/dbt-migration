{% snapshot scd_hinmei %}

{{
    config(
        unique_key="concat_ws('-',
                    langkbn,
                    pnc)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_hinmei') }}

{% endsnapshot %}