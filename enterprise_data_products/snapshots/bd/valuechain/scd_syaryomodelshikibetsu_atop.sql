{% snapshot scd_syaryomodelshikibetsu_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    tiikigrpcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syaryomodelshikibetsu_atop') }}

{% endsnapshot %}