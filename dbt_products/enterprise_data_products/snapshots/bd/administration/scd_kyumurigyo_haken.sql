{% snapshot scd_kyumurigyo_haken %}

{{
    config(
        unique_key="concat_ws('-',
                    syagai_cd,
                    h2ym,
                    h2dt,
                    h2kntsncnt)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kyumurigyo_haken') }}

{% endsnapshot %}
