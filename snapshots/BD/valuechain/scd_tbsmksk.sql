{% snapshot scd_tbsmksk %}

{{
    config(
        unique_key="ID ||'-'|| KYOUHAN ||'-'|| KYOTEN ||'-'|| YOBI",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbsmksk') }}

{% endsnapshot %}
