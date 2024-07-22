{% snapshot scd_yohinmeisai %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    cuno,
                    edano,
                    ym,
                    nykt,
                    tkcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_yohinmeisai') }}

{% endsnapshot %}
