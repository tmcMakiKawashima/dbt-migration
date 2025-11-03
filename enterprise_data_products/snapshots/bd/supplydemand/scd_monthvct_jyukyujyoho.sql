{% snapshot scd_monthvct_jyukyujyoho %}

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
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_monthvct_jyukyujyoho') }}

{% endsnapshot %}