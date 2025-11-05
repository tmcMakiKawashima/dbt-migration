{% snapshot scd_katashikibit_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syameino,
                    tuikou,
                    seg,
                    seq,
                    bitno
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_katashikibit_pixy') }}
{% endsnapshot %}