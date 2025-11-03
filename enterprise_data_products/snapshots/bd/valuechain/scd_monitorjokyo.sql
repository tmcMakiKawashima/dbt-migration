{% snapshot scd_monitorjokyo %}

{{
    config(
        unique_key = 'id',
        strategy = 'timestamp',
        updated_at = 'ldts',
        invalidate_hard_deletes = true,
    )
}}

select * from {{ ref('stg_monitorjokyo') }}

{% endsnapshot %}