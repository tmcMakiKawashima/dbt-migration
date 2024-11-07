{% snapshot scd_kintai_monthly %}

{{
    config(
        unique_key="concat_ws('-',
                    employee_cd,
                    h2gtjkntym,
                    h2knmtimcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kintai_monthly') }}

{% endsnapshot %}
