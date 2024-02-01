{% snapshot scd_ktrla025zz0kil3204 %}

{{
    config(
        unique_key="concat_ws('-',
                    mtkbn,
                    strno,
                    dtlno,
                    grtpa,
                    t1wcd,
                    refcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3204') }}

{% endsnapshot %}
