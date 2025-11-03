{% snapshot scd_kinomeisai_code_hikiate_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    kncode)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kinomeisai_code_hikiate_master_syaryosys') }}

{% endsnapshot %}