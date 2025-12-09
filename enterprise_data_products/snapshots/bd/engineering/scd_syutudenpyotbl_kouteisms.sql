{% snapshot scd_syutudenpyotbl_kouteisms %}
{{
    config(
        unique_key="concat_ws('-',
                    seppenno,
                    siryono,
                    syasyu,
                    syurui,
                    maker,
                    koumoku,
                    minor,
                    bunsi,
                    bunbo
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syutudenpyotbl_kouteisms') }}
{% endsnapshot %}