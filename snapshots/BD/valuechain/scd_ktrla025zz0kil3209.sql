{% snapshot scd_ktrla025zz0kil3209 %}

{{
    config(
        unique_key="concat_ws('-',
                    cdkbnid,
                    keykomoku,
                    datakomoku,
                    timestamp)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3209') }}

{% endsnapshot %}
