{% snapshot scd_shamei_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_shamei_master_syaryosys') }}

{% endsnapshot %}