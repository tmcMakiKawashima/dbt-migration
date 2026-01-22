{% snapshot scd_hinban_hikiate_koumusms %}

{{
    config(
        unique_key="concat_ws('-',
                    jigyoutaicd,
                    kouku,
                    renban,
                    syasyu,
                    siyoubui,
                    oyahin,
                    gc,
                    kohin,
                    ruibetu,
                    kanrikt,
                    ktkigo,
                    jikt01,
                    jikt02,
                    jikt03,
                    jikt04,
                    jikt05,
                    jikt06,
                    jikt07,
                    jikt08,
                    jikt09,
                    jikt10,
                    jikt11,
                    jikt12,
                    jikt13,
                    jikt14,
                    oyakt,
                    tck,
                    naigaikbn,
                    tehaishogokey,
                    idline,
                    unitkbn,
                    nisugata,
                    oderkbn,
                    shimukecd,
                    shimukekouku,
                    multisspkbn,
                    blkcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hinban_hikiate_koumusms') }}

{% endsnapshot %}