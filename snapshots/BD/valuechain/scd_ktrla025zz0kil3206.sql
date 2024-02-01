{% snapshot scd_ktrla025zz0kil3206 %}

{{
    config(
        unique_key="concat_ws('-',
                    mtkbn,
                    strno,
                    dtlno,
                    seibinmcd,
                    seibicd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3206') }}

{% endsnapshot %}
