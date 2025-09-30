{% snapshot scd_seisankokumeicheck_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    seisnkokumei)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_seisankokumeicheck_atop') }}
{% endsnapshot %}