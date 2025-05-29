{% snapshot scd_syasyu_siyousho %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    sno,
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syasyu_siyousho') }}

{% endsnapshot %}