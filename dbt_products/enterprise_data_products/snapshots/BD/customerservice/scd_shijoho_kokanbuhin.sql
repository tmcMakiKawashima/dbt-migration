{% snapshot scd_shijoho_kokanbuhin %}

{{
    config(
        unique_key="concat_ws('-',
                    ftr_no,
                    seq_ftr_rep)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_shijoho_kokanbuhin') }}

{% endsnapshot %}
