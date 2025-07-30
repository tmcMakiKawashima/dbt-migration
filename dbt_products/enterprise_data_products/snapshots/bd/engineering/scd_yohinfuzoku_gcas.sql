{% snapshot scd_yohinfuzoku_gcas %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    tuikocd,
                    syameino,
                    edaban,
                    fuzokukbn
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_yohinfuzoku_gcas') }}
{% endsnapshot %}