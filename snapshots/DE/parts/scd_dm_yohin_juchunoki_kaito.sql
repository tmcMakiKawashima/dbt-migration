{% snapshot scd_dm_yohin_juchunoki_kaito %}

{{
    config(
        unique_key="M_DLRCD ||'-'|| M_YUSOKBN ||'-'|| M_ORDENO ||'-'|| M_JUCHUYMD ||'-'|| M_JHINBAN ||'-'|| M_SYUBETSU",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_yohin_juchunoki_kaito') }}

{% endsnapshot %}
