{% snapshot scd_batchsyorijokyo_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    kinouid,
                    syasyug,
                    syoristatime
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_batchsyorijokyo_pixy') }}
{% endsnapshot %}