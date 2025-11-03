{% snapshot scd_katashikihenkanmaster_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    ctlkata,
                    hanbaicd
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_katashikihenkanmaster_pixy') }}
{% endsnapshot %}