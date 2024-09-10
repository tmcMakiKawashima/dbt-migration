{% snapshot scd_hanbaitentenpomaster %}

{{
    config(
        unique_key="concat_ws('-',
                    hanbaitencd,
                    tenpocd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_hanbaitentenpomaster') }}

{% endsnapshot %}
