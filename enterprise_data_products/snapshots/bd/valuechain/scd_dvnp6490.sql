{% snapshot scd_dvnp6490 %}

{{
    config(
        unique_key="concat_ws('-',
                    ORDRKEY,
                    JURRSYMD,
                    TANSKKEY)",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * From {{ ref('stg_dvnp6490') }}

{% endsnapshot %}