{% snapshot scd_kintai_daily %}

{{
    config(
        unique_key="concat_ws('-',
                    employee_cd,
                    h2ym)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kintai_daily') }}

{% endsnapshot %}
