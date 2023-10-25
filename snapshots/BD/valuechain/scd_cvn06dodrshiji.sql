{% snapshot scd_cvn06dodrshiji %}

{{
    config(
        unique_key="ordrkey ||'-'|| tanskkey ||'-'|| juchuymd",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_cvn06dodrshiji') }}

{% endsnapshot %}
