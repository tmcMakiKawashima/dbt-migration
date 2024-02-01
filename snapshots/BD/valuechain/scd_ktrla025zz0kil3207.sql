{% snapshot scd_ktrla025zz0kil3207 %}

{{
    config(
        unique_key="concat_ws('-',
                    mtkbn,
                    strno,
                    dtlno,
                    prtnum,
                    prtnmcd,
                    hnbncd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3207') }}

{% endsnapshot %}
