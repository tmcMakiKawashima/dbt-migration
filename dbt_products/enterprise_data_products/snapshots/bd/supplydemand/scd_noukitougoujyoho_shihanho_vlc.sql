{% snapshot scd_noukitougoujyoho_shihanho_vlc %}

{{
    config(
        unique_key='vhc_key',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_noukitougoujyoho_shihanho_vlc') }}

{% endsnapshot %}