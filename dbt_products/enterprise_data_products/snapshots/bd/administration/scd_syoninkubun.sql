{% snapshot scd_syoninkubun %}

{{
    config(
        unique_key="concat_ws('-',
                    sykicd,
                    slkbncd,
                    synrnkcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syoninkubun') }}

{% endsnapshot %}
