{% snapshot scd_shochihinban %}

{{
    config(
        unique_key = 'measurespartnoid',
        strategy = 'timestamp',
        updated_at = 'ldts',
        invalidate_hard_deletes = true,
    )
}}

select * from {{ ref('stg_shochihinban') }}

{% endsnapshot %}