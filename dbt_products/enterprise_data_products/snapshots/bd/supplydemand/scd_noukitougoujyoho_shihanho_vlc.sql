{% snapshot scd_noukitougoujyoho_shihanho_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vhc_key)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_noukitougoujyoho_shihanho_vlc') }}

{% endsnapshot %}