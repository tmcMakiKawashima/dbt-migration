{% snapshot scd_cam2204_jyukyujyoho %}

{{
    config(
        unique_key="concat_ws('-',
                    rmth,
                    line,
                    sno,
                    hktcd,
                    odno,
                    nisgt,
                    gaicd,
                    ucd,
                    smkcd,
                    spec,
                    symei,
                    wmi,
                    vds,
                    my,
                    load_date)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_cam2204_jyukyujyoho') }}

{% endsnapshot %}