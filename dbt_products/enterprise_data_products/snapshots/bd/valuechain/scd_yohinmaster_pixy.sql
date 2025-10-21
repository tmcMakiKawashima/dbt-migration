{% snapshot scd_yohinmaster_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    tuikou,
                    seg,
                    seq
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_yohinmaster_pixy') }}
{% endsnapshot %}