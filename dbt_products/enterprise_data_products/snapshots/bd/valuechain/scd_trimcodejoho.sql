{% snapshot scd_trimcodejoho %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    syasyu_cd,
                    hinban,
                    trmcd,
                    figno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_trimcodejoho') }}

{% endsnapshot %}