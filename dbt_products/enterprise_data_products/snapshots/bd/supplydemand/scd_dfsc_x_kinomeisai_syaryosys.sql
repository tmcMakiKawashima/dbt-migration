{% snapshot scd_dfsc_x_kinomeisai_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    dfsc,
                    kncode)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_dfsc_x_kinomeisai_syaryosys') }}

{% endsnapshot %}