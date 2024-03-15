{% snapshot scd_nyukoreki %}

{{
    config(
        unique_key="concat_ws('-',
                    KBSYADAI,
                    NOSYADAI,
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
