{% snapshot scd_employee_shumu %}

{{
    config(
        unique_key="employee_cd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_employee_shumu') }}

{% endsnapshot %}
