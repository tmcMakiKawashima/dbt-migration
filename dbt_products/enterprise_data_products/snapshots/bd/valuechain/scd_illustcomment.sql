{% snapshot scd_illustcomment %}

{{
    config(
        unique_key="concat_ws('-',
                    langkbn,
                    ilstcmtno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_illustcomment') }}

{% endsnapshot %}