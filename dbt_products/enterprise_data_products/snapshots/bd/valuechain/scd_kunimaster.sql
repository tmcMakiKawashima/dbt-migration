{% snapshot scd_kunimaster %}

{{
    config(
        unique_key = 'countrycd',
        strategy = 'timestamp',
        updated_at = 'ldts',
        invalidate_hard_deletes = true,
    )
}}

select * from {{ ref('stg_kunimaster') }}

{% endsnapshot %}