{% snapshot scd_glseppenst_kouteisms %}
{{
    config(
        unique_key="concat_ws('-',
                    seppenno,
                    siryono
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_glseppenst_kouteisms') }}
{% endsnapshot %}