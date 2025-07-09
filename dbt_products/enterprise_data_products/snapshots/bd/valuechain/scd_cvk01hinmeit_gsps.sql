{% snapshot scd_cvk01hinmeit_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    hinbansbetu,
                    syusbetu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cvk01hinmeit_gsps') }}

{% endsnapshot %}