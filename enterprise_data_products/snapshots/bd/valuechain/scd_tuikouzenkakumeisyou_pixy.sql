{% snapshot scd_tuikouzenkakumeisyou_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    tuikou
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_tuikouzenkakumeisyou_pixy') }}
{% endsnapshot %}