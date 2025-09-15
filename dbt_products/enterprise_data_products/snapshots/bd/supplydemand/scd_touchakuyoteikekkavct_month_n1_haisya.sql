{% snapshot scd_touchakuyoteikekkavct_month_n1_haisya %}
{{
    config(
        unique_key="concat_ws('-',
                    idno,
                    kaisu,
                    syear
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_touchakuyoteikekkavct_month_n1_haisya') }}
{% endsnapshot %}