{% snapshot scd_noryokuwaku_month_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    nengetu,
                    kncode,
                    dsyubetum)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_noryokuwaku_month_syaryosys') }}

{% endsnapshot %}