{% snapshot scd_dfsc_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dfsc)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_dfsc_master_syaryosys') }}

{% endsnapshot %}