{% snapshot scd_syasyusiji_gcas %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    hansiyono8,
                    jyokenno
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syasyusiji_gcas') }}
{% endsnapshot %}