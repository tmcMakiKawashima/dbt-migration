{% snapshot scd_syaryokatashikijoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    syakata,
                    syasyu_cd,
                    vinwmivds,
                    katano)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syaryokatashikijoho') }}

{% endsnapshot %}