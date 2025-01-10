{% snapshot scd_riyosyameimaster %}

{{
    config(
        unique_key="concat_ws('-',
                    cd_model_nm)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_riyosyameimaster') }}

{% endsnapshot %}