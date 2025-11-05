{% snapshot scd_warning_list_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_warning_list_syaryosys') }}

{% endsnapshot %}