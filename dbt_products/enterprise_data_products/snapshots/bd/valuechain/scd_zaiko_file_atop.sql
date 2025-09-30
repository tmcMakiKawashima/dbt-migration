{% snapshot scd_zaiko_file_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    kaknoukbn,
                    zaikosu,
                    jknsu,
                    ksyuzsu,
                    tknkruisu,
                    tkskruisu,
                    nsksutsu,
                    snttssu,
                    torsaisu,
                    kpksutsu,
                    skdsu,
                    jcukztsruisu,
                    mtuserid,
                    mttime,
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_zaiko_file_atop') }}
{% endsnapshot %}