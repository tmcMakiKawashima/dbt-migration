{% snapshot scd_line_cal_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    nen,
                    tuki,
                    kline)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_line_cal_syaryosys') }}

{% endsnapshot %}