{% snapshot scd_maker_line_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    maker,
                    idline)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_maker_line_syaryosys') }}

{% endsnapshot %}