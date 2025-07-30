{% snapshot scd_syasyufuzoku_gcas %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    hansiyono8,
                    hankata
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syasyufuzoku_gcas') }}
{% endsnapshot %}