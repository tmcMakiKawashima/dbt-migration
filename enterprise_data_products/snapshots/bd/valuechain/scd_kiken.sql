{% snapshot scd_kiken %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban10,
                    syusbetu,
                    seppenjun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kiken') }}

{% endsnapshot %}