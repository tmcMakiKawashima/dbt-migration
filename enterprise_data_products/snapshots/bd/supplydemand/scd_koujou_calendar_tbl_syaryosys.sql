{% snapshot scd_koujou_calendar_tbl_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    ymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_koujou_calendar_tbl_syaryosys') }}

{% endsnapshot %}