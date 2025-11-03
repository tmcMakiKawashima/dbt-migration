{% snapshot scd_shipnamemst_vlc %}

{{
    config(
        unique_key='fune_cd',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_shipnamemst_vlc') }}

{% endsnapshot %}