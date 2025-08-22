{% snapshot scd_tiikimst_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    r_area_code,
                    load_date)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_tiikimst_jyukyujyoho') }}

{% endsnapshot %}