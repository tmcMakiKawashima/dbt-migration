{% snapshot scd_tokuchokigojoho %}

{{
    config(
        unique_key="concat_ws('-',
                    langkbn,
                    ctlgcd,
                    tokukbn,
                    tokukg)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_tokuchokigojoho') }}

{% endsnapshot %}
