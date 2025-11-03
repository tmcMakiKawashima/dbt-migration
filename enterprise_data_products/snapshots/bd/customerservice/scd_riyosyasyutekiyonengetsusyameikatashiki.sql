{% snapshot scd_riyosyasyutekiyonengetsusyameikatashiki %}

{{
    config(
        unique_key="concat_ws('-',
                    cd_pubbnd,
                    syamei,
                    cd_vtype,
                    dd_pubbnd_trmfrym,
                    kosyo_kt)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_riyosyasyutekiyonengetsusyameikatashiki') }}

{% endsnapshot %}