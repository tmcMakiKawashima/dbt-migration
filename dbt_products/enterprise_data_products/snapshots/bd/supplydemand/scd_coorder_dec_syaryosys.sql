{% snapshot scd_coorder_dec_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    odno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_coorder_dec_syaryosys') }}

{% endsnapshot %}