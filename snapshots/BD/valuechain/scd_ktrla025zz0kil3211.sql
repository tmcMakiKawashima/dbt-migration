{% snapshot scd_ktrla025zz0kil3211 %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    tmpcd,
                    tmpnm,
                    startmt,
                    stopmt)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3211') }}

{% endsnapshot %}
