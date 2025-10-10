{% snapshot scd_kaigaitekiyouhankadistenzan_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    dist,
                    fdcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kaigaitekiyouhankadistenzan_atop') }}

{% endsnapshot %}