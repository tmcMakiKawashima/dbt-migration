{% snapshot scd_systemmei_aisac%}

{{
    config( 
        unique_key="concat_ws('-', system)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_systemmei_aisac') }}

 {% endsnapshot %}