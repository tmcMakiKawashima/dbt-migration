{% snapshot scd_shikaku %}

{{
    config(
        unique_key="concat_ws('-',
                    skkcd,
                    skktkkbncd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_shikaku') }}

{% endsnapshot %}
