{% snapshot scd_genyohinmaster %}
{{
    config(
        unique_key="concat_ws('-',
                    yohinsyamei,
                    tuikou,
                    seg,
                    seq)",

        strategy='timestamp',
        updated_at='kousin',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_genyohinmaster') }}
{% endsnapshot %}