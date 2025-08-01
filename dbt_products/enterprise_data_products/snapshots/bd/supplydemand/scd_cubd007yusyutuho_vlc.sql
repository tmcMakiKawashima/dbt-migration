{% snapshot scd_cubd007yusyutuho_vlc %}

{{
    config(
        unique_key='urn',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cubd007yusyutuho_vlc') }}

{% endsnapshot %}