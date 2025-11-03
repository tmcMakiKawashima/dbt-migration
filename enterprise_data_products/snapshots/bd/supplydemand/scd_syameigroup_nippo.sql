{% snapshot scd_syameigroup_nippo %}

{{
    config(
    unique_key="concat_ws('-',
                send_date,
                ymd,
                jpn_local_div,
                areacd,
                country_cd,
                psc,
                affiliate_cd,
                plant_cd,
                line_cd,
                daily_report_car_grcd
                )",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syameigroup_nippo') }}

{% endsnapshot %}
