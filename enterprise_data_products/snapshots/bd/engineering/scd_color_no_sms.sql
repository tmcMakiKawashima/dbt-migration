{% snapshot scd_color_no_sms %}

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

select * from {{ ref('stg_color_no_sms') }}

{% endsnapshot %}
