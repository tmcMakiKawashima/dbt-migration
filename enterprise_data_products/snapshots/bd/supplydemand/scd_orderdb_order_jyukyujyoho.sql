{% snapshot scd_orderdb_order_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    segmei,
                    dlrcd,
                    odno,
                    ojyy)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_orderdb_order_jyukyujyoho') }}

{% endsnapshot %}