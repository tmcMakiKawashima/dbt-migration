{% snapshot scd_kaigaitekiyouhankakawasetsuuka_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    tukacd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kaigaitekiyouhankakawasetsuuka_atop') }}

{% endsnapshot %}