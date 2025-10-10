{% snapshot scd_kaigaitokkafob_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    dist,
                    fdcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kaigaitokkafob_atop') }}

{% endsnapshot %}