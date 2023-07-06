{% snapshot scd_DVNP0680 %}

{{
    config(
        unique_key="ORDRKEY ||'-'|| JYUSYYMD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_DVNP0680') }}

{% endsnapshot %}
