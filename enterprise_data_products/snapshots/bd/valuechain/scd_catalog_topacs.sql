{% snapshot scd_catalog_topacs %}

{{
    config(
        unique_key="concat_ws('-',
                    catalg,
                    syasyu,
                    figno,
                    pnc1,
                    hkhin,
                    kosu,
                    jissijkara,
                    setpospnno,
                    bnrsiypnno,
                    trmgaihan,
                    katahyono,
                    hikiatetkgkbn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_catalog_topacs') }}

{% endsnapshot %}