{% snapshot scd_cubd002shihandtl_vlc %}

{{
    config(
        unique_key='vhc_key',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cubd002shihandtl_vlc') }}

{% endsnapshot %}