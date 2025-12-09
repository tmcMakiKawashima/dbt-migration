{% snapshot scd_battingjoho_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    tuikocd,
                    seg,
                    seq,
                    renban
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_battingjoho_pixy') }}
{% endsnapshot %}