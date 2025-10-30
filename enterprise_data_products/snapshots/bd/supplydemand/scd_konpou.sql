{% snapshot scd_konpou %}

{{
    config(
        unique_key="concat_ws('-',
                    knp_yr,
                    idntno)",

        strategy='timestamp',
        updated_at='updatetime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_konpou') }}

{% endsnapshot %}