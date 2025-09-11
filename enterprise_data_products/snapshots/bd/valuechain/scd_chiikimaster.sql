{% snapshot scd_chiikimaster %}

{{
    config(
        unique_key = 'areacd',
        strategy = 'timestamp',
        updated_at = 'ldts',
        invalidate_hard_deletes = true,
    )
}}
select * from {{ ref('stg_chiikimaster') }}

{% endsnapshot %}