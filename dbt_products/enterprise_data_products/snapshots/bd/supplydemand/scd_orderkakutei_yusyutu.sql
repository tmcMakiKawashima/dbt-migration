{% snapshot scd_orderkakutei_yusyutu %}
{{
    config(
        unique_key="concat_ws('-',
                    sno,
                    syamei,
                    ktai
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_orderkakutei_yusyutu') }}
{% endsnapshot %}