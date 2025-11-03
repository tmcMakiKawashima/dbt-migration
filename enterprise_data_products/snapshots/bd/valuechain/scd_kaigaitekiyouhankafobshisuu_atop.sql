{% snapshot scd_kaigaitekiyouhankafobshisuu_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    rgncd3,
                    oprccls)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kaigaitekiyouhankafobshisuu_atop') }}

{% endsnapshot %}