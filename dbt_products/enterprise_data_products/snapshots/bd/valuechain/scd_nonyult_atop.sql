{% snapshot scd_nonyult_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    pno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_nonyult_atop') }}
{% endsnapshot %}