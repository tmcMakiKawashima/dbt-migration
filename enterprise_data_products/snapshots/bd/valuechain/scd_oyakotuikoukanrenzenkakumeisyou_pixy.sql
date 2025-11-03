{% snapshot scd_oyakotuikoukanrenzenkakumeisyou_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    stcd
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_oyakotuikoukanrenzenkakumeisyou_pixy') }}
{% endsnapshot %}