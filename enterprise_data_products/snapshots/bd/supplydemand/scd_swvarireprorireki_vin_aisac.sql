{% snapshot scd_swvarireprorireki_vin_aisac%}

{{
    config( 
        unique_key="concat_ws('-',
                    vin,
                    compositekey1)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_swvarireprorireki_vin_aisac') }} 

 {% endsnapshot %}