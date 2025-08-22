{% snapshot scd_kunimst_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    r_country_code,
                    load_date)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kunimst_jyukyujyoho') }}

{% endsnapshot %}