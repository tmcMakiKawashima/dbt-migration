{% snapshot scd_3a_production_progress_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    pscexlk,
                    plantcode,
                    line,
                    tp,
                    idline,
                    ndate,
                    shift)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_3a_production_progress_hostalc') }}

{% endsnapshot %}