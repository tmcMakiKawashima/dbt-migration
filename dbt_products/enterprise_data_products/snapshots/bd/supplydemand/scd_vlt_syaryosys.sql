{% snapshot scd_vlt_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    line,
                    sno,
                    odno,
                    ssyy,
                    ssmm,
                    ssdd,
                    symei,
                    load_date)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_vlt_syaryosys') }}

{% endsnapshot %}