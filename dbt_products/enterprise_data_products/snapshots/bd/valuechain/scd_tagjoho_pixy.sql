{% snapshot scd_tagjoho_pixy %}
{{
    config(
                unique_key="concat_ws('-'
                    ,tuikocd
                    ,tagcd
                    )",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_tagjoho_pixy') }}
{% endsnapshot %}
