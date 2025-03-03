{% snapshot scd_buisyobunruikensakujoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    chubnrcd,
                    svglayermei,
                    figno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ref('stg_buisyobunruikensakujoho')}}

{% endsnapshot %}