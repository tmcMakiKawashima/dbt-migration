{% snapshot scd_3a_virtual_line_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    pscexlk,
                    plantcode,
                    tp,
                    urn,
                    line)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_3a_virtual_line_hostalc') }}

{% endsnapshot %}