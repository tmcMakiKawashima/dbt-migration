{% snapshot scd_riyosyasyusedaitekiyonengetsu %}

{{
    config(
        unique_key="concat_ws('-',
                    cd_pubbnd,
                    dd_pubbnd_trmfrym)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_riyosyasyusedaitekiyonengetsu') }}

{% endsnapshot %}