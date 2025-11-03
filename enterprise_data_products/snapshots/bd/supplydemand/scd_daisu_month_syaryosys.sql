{% snapshot scd_daisu_month_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    shamei,
                    sno,
                    shinq,
                    firmymj,
                    kncode)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_daisu_month_syaryosys') }}

{% endsnapshot %}