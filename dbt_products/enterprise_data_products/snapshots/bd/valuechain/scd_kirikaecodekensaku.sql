{% snapshot scd_kirikaecodekensaku %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    kiricd,
                    prtren)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kirikaecodekensaku') }}

{% endsnapshot %}