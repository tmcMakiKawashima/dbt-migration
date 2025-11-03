{% snapshot scd_jyuchuzan_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    chumon)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jyuchuzan_syaryosys') }}

{% endsnapshot %}