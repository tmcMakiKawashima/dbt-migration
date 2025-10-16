{% snapshot scd_sonekikanri_sc_mieruka %}

{{
    config(
        unique_key="concat_ws('-',
                    thyono,
                    jissekiym,
                    hinban,
                    distfd,
                    renban)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_sonekikanri_sc_mieruka') }}

{% endsnapshot %}