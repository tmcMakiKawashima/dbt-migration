{% snapshot scd_cmf_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    idntno,
                    load_date)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cmf_syaryosys') }}

{% endsnapshot %}