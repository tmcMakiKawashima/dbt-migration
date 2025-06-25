{% snapshot scd_cam2073_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ojyy,
                    segmei,
                    dlrcd,
                    odno,
                    kubn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cam2073_jyukyujyoho') }}

{% endsnapshot %}