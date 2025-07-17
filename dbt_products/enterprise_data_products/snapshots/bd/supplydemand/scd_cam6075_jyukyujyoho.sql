{% snapshot scd_cam6075_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    carnm_cd,
                    aply_dt_kara)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cam6075_jyukyujyoho') }}

{% endsnapshot %}