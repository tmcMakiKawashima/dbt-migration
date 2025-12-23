{% snapshot scd_subarugetsudoseikei_syaryosys%}

{{
    config( 
        unique_key="concat_ws('-',
                    ktsk,
                    sp,
                    op,
                    onkn_kbn,
                    gsclr,
                    nsclr)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_subarugetsudoseikei_syaryosys') }} 

 {% endsnapshot %}