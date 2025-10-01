{% snapshot scd_riyopubmaster2 %}

{{
    config(
        unique_key="concat_ws('-',
                    no_ofr_alt_pub,
                    cd_pubbnd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_riyopubmaster2') }}

{% endsnapshot %}