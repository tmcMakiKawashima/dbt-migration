{% snapshot scd_tbuserm %}

{{
    config(
        unique_key="concat_ws('-',
                    KYOUHAN,
                    USRCOD)",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbuserm') }}

{% endsnapshot %}
