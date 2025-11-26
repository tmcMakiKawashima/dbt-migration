{% snapshot scd_swevent_ebidensu_aisac %}

{{
    config(
        unique_key="concat_ws('-',
                    eventno,
                    syasyu)",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_swevent_ebidensu_aisac') }}

{% endsnapshot %}