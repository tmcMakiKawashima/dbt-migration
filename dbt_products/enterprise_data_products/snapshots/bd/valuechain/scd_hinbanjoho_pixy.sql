{% snapshot scd_hinbanjoho_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyug,
                    tuikocd,
                    siyousyono,
                    hankata,
                    vari,
                    lv1hinban,
                    htyhkykbn,
                    hinban,
                    iroruibetu,
                    syaryouclr
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hinbanjoho_pixy') }}
{% endsnapshot %}