{% snapshot scd_irofuzoku_gcas %}
{{
    config(
        unique_key="concat_ws('-',
                    naigaikbn,
                    clrno,
                    syasyu
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_irofuzoku_gcas') }}
{% endsnapshot %}