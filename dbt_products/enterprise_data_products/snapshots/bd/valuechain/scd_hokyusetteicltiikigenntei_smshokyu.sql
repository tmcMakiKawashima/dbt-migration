{% snapshot scd_hokyusetteicltiikigenntei_smshokyu%}

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
                    ruibetu,
                    sepjunk,
                    gentetiki)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hokyusetteicltiikigenntei_smshokyu') }} 

 {% endsnapshot %}