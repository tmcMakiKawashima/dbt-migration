{% snapshot scd_haishayoubo_jpass %}
{{
    config(
        unique_key="concat_ws('-',
                    ym
                    ,caltimingkbn
                    ,shamei
                    ,sno
                    ,yosokbn
                    ,yosoren
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_haishayoubo_jpass') }}
{% endsnapshot %}