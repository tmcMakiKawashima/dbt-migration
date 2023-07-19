{% snapshot scd_dvsf509a %}

{{
    config(
        unique_key="TYOTATHB ||'-'|| KAKNOUKBN ||'-'|| SRSIRSKCD ||'-'|| TEKIYOKAISIYMD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvsf509a') }}

{% endsnapshot %}
