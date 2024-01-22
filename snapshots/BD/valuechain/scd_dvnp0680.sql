{% snapshot scd_dvnp0680 %}

{{
    config(
        unique_key="concat_ws('-', 
                    ordrkey,
                    juchuymd)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_dvnp0680') }}

{% endsnapshot %}
