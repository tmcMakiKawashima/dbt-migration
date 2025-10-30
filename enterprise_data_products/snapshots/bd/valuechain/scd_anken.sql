{% snapshot scd_anken %}

{{
    config(
        unique_key = 'matterid',
        strategy = 'timestamp',
        updated_at = 'ldts',
        invalidate_hard_deletes = true,
    )
}}

select * from {{ ref('stg_anken') }}

{% endsnapshot %}
