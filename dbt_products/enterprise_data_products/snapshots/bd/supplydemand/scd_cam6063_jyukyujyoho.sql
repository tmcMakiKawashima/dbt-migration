{% snapshot scd_cam6063_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    segmei,
                    renkey_hkata,
                    renkry_sedai,
                    aply_dt_kara)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cam6063_jyukyujyoho') }}

{% endsnapshot %}