{% snapshot scd_shijoho_honbuntext %}
{{
    config(
        unique_key="concat_ws('-',
                    ftr_no,
                    seq_ftr_body)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_shijoho_honbuntext') }}
{% endsnapshot %}