{% snapshot scd_sfx_kihonjyoho_tbl_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    r_prod_month,
                    r_dist_code,
                    r_shiyos,
                    r_katashiki,
                    r_pkg_code,
                    r_sfx_code)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_sfx_kihonjyoho_tbl_jyukyujyoho') }}

{% endsnapshot %}