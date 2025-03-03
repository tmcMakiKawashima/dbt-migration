{% snapshot scd_specname %}

{{
    config(
        unique_key="concat_ws('-', 
                    syasyu,
                    shiyodai, 
                    shiyosai, 
                    sketa, 
                    skigo,
                    sijikara)",

        strategy='timestamp',
        updated_at='mtdate',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_specname') }}

{% endsnapshot %}
