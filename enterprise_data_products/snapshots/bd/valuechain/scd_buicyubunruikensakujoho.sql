{% snapshot scd_buicyubunruikensakujoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    daibnrcd,
                    chubnrcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_buicyubunruikensakujoho') }}

{% endsnapshot %}