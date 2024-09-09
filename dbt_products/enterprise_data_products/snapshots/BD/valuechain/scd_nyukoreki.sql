{% snapshot scd_nyukoreki %}

{{
    config(
        unique_key="concat_ws('-',
                    kbsyadai,
                    nosyadai,
                    seisanymd,
                    nyukohanbaitencd,
                    jutyuno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_nyukoreki') }}

{% endsnapshot %}
