{% snapshot scd_syamei %}

{{
    config(
        unique_key="concat_ws('-',
                    ctlgcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syamei') }}

{% endsnapshot %}