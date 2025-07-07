{% snapshot scd_riyosyasyusedai %}

{{
    config(
        unique_key="concat_ws('-',
                    cd_pubbnd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_riyosyasyusedai') }}

{% endsnapshot %}