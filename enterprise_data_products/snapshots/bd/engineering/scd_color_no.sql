{% snapshot scd_color_no %}

{{
    config(
        unique_key="concat_ws('-',
                    gclrno
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_color_no') }}

{% endsnapshot %}
