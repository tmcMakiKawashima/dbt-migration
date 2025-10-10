{% snapshot scd_buidaibunruikensakujoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    daibnrcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ref('stg_buidaibunruikensakujoho')}}

{% endsnapshot %}