{% snapshot scd_zissiziki_smshokyu%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu32,
                    syasyu,
                    kumitate,
                    bui,
                    kata,
                    sepnok)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_zissiziki_smshokyu') }} 

 {% endsnapshot %}