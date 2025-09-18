{% snapshot scd_karikarifuri_syaryosys %}

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

select * from {{ ref('stg_karikarifuri_syaryosys') }}

{% endsnapshot %}