{% snapshot scd_kumitatename %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    kumitate)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kumitatename') }}

{% endsnapshot %}