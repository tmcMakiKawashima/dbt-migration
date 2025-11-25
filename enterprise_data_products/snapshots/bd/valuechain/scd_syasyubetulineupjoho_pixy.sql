{% snapshot scd_syasyubetulineupjoho_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    tuikocd
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syasyubetulineupjoho_pixy') }}
{% endsnapshot %}