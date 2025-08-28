{% snapshot scd_noryokuwaku_date_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    renkey_shamei,
                    renkey_sno,
                    renkey_nen,
                    renkey_tuki,
                    renkey_kncode,
                    renkey_knkubn,
                    dsyubetum)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_noryokuwaku_date_syaryosys') }}

{% endsnapshot %}