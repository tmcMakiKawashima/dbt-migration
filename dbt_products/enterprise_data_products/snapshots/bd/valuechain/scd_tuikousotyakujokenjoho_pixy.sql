{% snapshot scd_tuikousotyakujokenjoho_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyug,
                    tuikocd,
                    siyousyono,
                    hankata,
                    kotuikocd,
                    vari,
                    varix
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_tuikousotyakujokenjoho_pixy') }}
{% endsnapshot %}