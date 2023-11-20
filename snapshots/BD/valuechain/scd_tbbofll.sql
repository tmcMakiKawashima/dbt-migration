{% snapshot scd_tbbofll %}

{{
    config(
        unique_key="concat_ws('-',
                    kyouhan,
                    hinban,
                    mkbn,
                    nyukkten,
                    chumon,
                    usercd,
                    urisflg,
                    jchuymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbbofll') }}

{% endsnapshot %}