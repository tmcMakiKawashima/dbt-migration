{% snapshot scd_employee_kubun %}

{{
    config(
        unique_key="jigkbncd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_employee_kubun') }}

{% endsnapshot %}
