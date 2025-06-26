{% snapshot scd_lineupmaster_pixy %}
{{
    config(
        unique_key="concat_ws('-'
                    ,hincd
                    ,syucd
                    )",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_lineupmaster_pixy') }}
{% endsnapshot %}
