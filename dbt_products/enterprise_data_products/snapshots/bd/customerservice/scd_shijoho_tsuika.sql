{% snapshot scd_shijoho_tsuika %}
{{
    config(
        unique_key="ftr_no",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_shijoho_tsuika') }}
{% endsnapshot %}