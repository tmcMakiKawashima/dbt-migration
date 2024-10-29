{% snapshot scd_figkensaku %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    hinban,
                    pnc,
                    figno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_figkensaku') }}

{% endsnapshot %}