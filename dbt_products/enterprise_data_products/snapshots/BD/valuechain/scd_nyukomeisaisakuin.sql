{% snapshot scd_nyukomeisaisakuin %}

{{
    config(
        unique_key="concat_ws('-',
                    nyukohanbaitencd,
                    jutyuno,
                    seisany,
                    seisanmd,
                    nyukono)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_nyukomeisaisakuin') }}

{% endsnapshot %}
