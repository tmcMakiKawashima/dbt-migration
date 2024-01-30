{% snapshot scd_ktrla025zz0kil3202 %}

{{
    config(
        unique_key="concat_ws('-',
                    mtkbn,
                    r001,
                    carno,
                    sttldy,
                    dlrcd,
                    ordrno,
                    r006,
                    r007,
                    r008,
                    r009,
                    r010,
                    r011,
                    r012,
                    r013,
                    r014,
                    r015,
                    r016)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3202') }}

{% endsnapshot %}
