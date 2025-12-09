{% snapshot scd_syukkosagyohinban_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    shinban,
                    kaknoukbn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syukkosagyohinban_atop') }}
{% endsnapshot %}