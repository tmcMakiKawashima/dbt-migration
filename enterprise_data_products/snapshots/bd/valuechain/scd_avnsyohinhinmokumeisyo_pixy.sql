{% snapshot scd_avnsyohinhinmokumeisyo_pixy %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyug,
                    dbase,
                    avnmodely,
                    oiban,
                    syouhinno
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_avnsyohinhinmokumeisyo_pixy') }}
{% endsnapshot %}