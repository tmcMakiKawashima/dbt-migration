{% snapshot scd_bunkaizuimagekanri %}

{{
    config(
        unique_key="concat_ws('-',
                    hansno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_bunkaizuimagekanri') }}

{% endsnapshot %}
