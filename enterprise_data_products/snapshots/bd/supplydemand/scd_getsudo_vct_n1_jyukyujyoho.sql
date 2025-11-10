{% snapshot scd_getsudo_vct_n1_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    plan_month,
                    id_line_cd,
                    sno,
                    alloc_kata_cd,
                    order_no,
                    ske_date,
                    pkg,
                    ext_cd,
                    trim_cd,
                    int_cd,
                    dest_cd,
                    prod_spec,
                    pcd_model_cd,
                    wmi,
                    vds,
                    model_year)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_getsudo_vct_n1_jyukyujyoho') }}

{% endsnapshot %}