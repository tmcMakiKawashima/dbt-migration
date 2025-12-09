{% snapshot scd_hokyusetteitiikigenntei_smshokyu%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu,
                    kumitate,
                    bui,
                    vari,
                    oyahin,
                    gc,
                    kohin,
                    sepjunk,
                    gentetiki)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hokyusetteitiikigenntei_smshokyu') }} 

 {% endsnapshot %}