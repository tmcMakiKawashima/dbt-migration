{% snapshot scd_variationname %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    kumitate,
                    bui,
                    vari)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_variationname') }}

{% endsnapshot %}