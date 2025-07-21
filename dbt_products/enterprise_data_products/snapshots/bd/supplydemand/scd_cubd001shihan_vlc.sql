{% snapshot scd_cubd001shihan_vlc %}

{{
    config(
        unique_key='vhc_key',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cubd001shihan_vlc') }}

{% endsnapshot %}