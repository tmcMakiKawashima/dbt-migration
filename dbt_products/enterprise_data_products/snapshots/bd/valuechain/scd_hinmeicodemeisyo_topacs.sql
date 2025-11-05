{% snapshot scd_hinmeicodemeisyo_topacs %}

{{
    config(
        unique_key="concat_ws('-',
                    pnc1,
                    langua)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinmeicodemeisyo_topacs') }}

{% endsnapshot %}