{% snapshot scd_dvsf509a %}

{{
    config(
        unique_key="concat_ws('-',
                    tyotathb,
                    kaknoukbn,
                    srsirskcd,
                    tekiyokaisiymd)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvsf509a') }}

{% endsnapshot %}
