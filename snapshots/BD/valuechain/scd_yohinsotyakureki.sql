{% snapshot scd_yohinsotyakureki %}

{{
    config(
        unique_key="concat_ws('-',
                    kbsyadai,
                    nosyadai,
                    ddtorituke,
                    cdyouhinban,
                    cdtorihan,
                    cdtoritenpo)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_yohinsotyakureki') }}

{% endsnapshot %}
