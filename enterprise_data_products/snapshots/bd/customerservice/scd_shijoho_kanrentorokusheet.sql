{% snapshot scd_shijoho_kanrentorokusheet %}

{{
    config(
        unique_key="concat_ws('-',
                    ftr_no,
                    reg_sheet_no)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_shijoho_kanrentorokusheet') }}

{% endsnapshot %}