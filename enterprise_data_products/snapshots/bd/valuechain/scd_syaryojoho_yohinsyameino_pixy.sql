{% snapshot scd_syaryojoho_yohinsyameino_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyug,
                    siyousyono,
                    hankata
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syaryojoho_yohinsyameino_pixy') }}
{% endsnapshot %}