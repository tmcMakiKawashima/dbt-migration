{% snapshot scd_shijoho_bugaihaihu %}

{{
    config(
        unique_key="concat_ws('-',
                    ftr_no,
                    outside_cmpny_code,
                    outside_div_code)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_shijoho_bugaihaihu') }}

{% endsnapshot %}