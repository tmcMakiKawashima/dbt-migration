{% snapshot scd_disp_partnm05_iqas%}

{{
    config( 
        unique_key="concat_ws('-',
                    table_data_id,
                    table_data_seq)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_disp_partnm05_iqas') }} 

 {% endsnapshot %}