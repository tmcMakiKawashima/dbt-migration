{% snapshot scd_cubd003shihanho_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vhc_key)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_cubd003shihanho_vlc') }}

{% endsnapshot %}