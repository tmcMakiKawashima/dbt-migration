{% snapshot scd_kaigaidistbetsujutyujisseki_daily_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    mntkbn,
                    hinban,
                    dlrcd,
                    odrzok,
                    keikakuodrkbn,
                    odrno,
                    yusokbn,
                    juchuymd,
                    juchusu7,
                    hind5,
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kaigaidistbetsujutyujisseki_daily_atop') }}
{% endsnapshot %}