{% snapshot scd_hinban_hikiate %}

{{
    config(
        unique_key="concat_ws('-',
                    gclrno,
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinban_hikiate') }}

{% endsnapshot %}
