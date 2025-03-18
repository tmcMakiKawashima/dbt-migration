{% snapshot scd_riyoframemaster %}

{{
    config(
        unique_key="concat_ws('-',
                    no_vin_frameno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_riyoframemaster') }}

{% endsnapshot %}