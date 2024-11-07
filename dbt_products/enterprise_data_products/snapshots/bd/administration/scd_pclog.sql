{% snapshot scd_pclog %}

{{
    config(
        unique_key="concat_ws('-',
                    employee_cd,
                    kdtiym)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_pclog') }}

{% endsnapshot %}
