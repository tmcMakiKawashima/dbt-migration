{% snapshot scd_dfsc_kinomeisaicd_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    sno,
                    shamei,
                    dfsc,
                    kncode)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_dfsc_kinomeisaicd_syaryosys') }}

{% endsnapshot %}