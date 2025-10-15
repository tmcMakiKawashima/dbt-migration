{% snapshot scd_dwhsyameimst_jyukyujyoho %}

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

select * from {{ ref('stg_dwhsyameimst_jyukyujyoho') }}

{% endsnapshot %}