{% snapshot scd_hinmokuhiki_gcas %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    db,
                    hansiyono8,
                    hinmoku,
                    syurui,
                    jyokenno
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hinmokuhiki_gcas') }}
{% endsnapshot %}