{% snapshot scd_kinobetsu_noryoku_waku_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    kncode,
                    kbn,
                    yyyymm)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kinobetsu_noryoku_waku_syaryosys') }}

{% endsnapshot %}