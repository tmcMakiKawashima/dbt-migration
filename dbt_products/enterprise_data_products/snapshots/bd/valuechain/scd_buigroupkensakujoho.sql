{% snapshot scd_buigroupkensakujoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    chubnrcd,
                    svglayermei)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ref('stg_buigroupkensakujoho')}}

{% endsnapshot %}