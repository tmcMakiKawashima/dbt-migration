{% snapshot scd_katashikipattern %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd,
                    epckataptno,
                    katano)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_katashikipattern') }}

{% endsnapshot %}