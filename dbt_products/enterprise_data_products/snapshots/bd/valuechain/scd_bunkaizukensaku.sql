{% snapshot scd_bunkaizukensaku %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    figno,
                    bnkren4,
                    jissijikik,
                    jissijikim)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_bunkaizukensaku') }}

{% endsnapshot %}