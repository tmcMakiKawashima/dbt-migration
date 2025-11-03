{% snapshot scd_emokujikensaku %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    emkjgrpcd,
                    figno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_emokujikensaku') }}

{% endsnapshot %}