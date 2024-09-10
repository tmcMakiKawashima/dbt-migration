{% snapshot scd_shijoho_syareki %}

{{
    config(
        unique_key="ftr_no",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_shijoho_syareki') }}

{% endsnapshot %}
