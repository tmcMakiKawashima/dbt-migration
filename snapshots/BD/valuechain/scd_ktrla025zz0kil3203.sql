{% snapshot scd_ktrla025zz0kil3203 %}

{{
    config(
        unique_key="concat_ws('-',
                    mtkbn,
                    dlrcd,
                    ordrno,
                    sttldy,
                    nyukono)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3203') }}

{% endsnapshot %}
