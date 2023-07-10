{% snapshot scd_dvnp0680 %}

{{
    config(
        unique_key="ORDRKEY ||'-'|| JYUSYYMD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvnp0680') }}

{% endsnapshot %}
