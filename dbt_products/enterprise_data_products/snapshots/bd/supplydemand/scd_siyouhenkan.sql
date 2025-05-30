{% snapshot scd_siyouhenkan %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    shiyodai,
                    shiyosai,
                    s1keta,
                    s1kigo,
                    ctlkata)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_siyouhenkan') }}

{% endsnapshot %}
