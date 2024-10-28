{% snapshot scd_figmeisyo %}

{{
    config(
        unique_key="concat_ws('-',
                    langkbn,
                    figno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_figmeisyo') }}

{% endsnapshot %}