{% snapshot scd_cam2072_jyukyujyoho %}

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

select * from {{ ref('stg_cam2072_jyukyujyoho') }}

{% endsnapshot %}