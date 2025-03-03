{% snapshot scd_framekatashiki %}

{{
    config(
        unique_key="concat_ws('-',
                    frmnokata,
                    frmno,
                    mdlyearkbn,
                    vin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_framekatashiki') }}

{% endsnapshot %}