{% snapshot scd_tbsmksk_noki %}

{{
    config(
        unique_key="concat_ws('-', 
                    id, 
                    kyouhan, 
                    nyukkten,
                    makercd,
                    ktenkbn,
                    ptnno,
                    yobi)",

        strategy='check',
        check_cols=['nokismkskcd',
                    'hikizaikbn',
                    'deletedate'],
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbsmksk_noki') }}

{% endsnapshot %}
