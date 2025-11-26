{% snapshot scd_hokyuhinbankouseikoute_smshokyu%}

{{
    config( 
        unique_key="concat_ws('-',
                    syusbetu,
                    syutuhin,
                    kyokucd,
                    oyahin,
                    kohin,
                    jikt1,
                    jikt2,
                    jikt3,
                    jikt4,
                    jikt5,
                    jikt6,
                    jikt7,
                    jikt8,
                    jikt9,
                    jikt10,
                    jikt11,
                    jikt12,
                    jikt13,
                    jikt14,
                    oyakt,
                    sepjunk)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hokyuhinbankouseikoute_smshokyu') }} 

 {% endsnapshot %}