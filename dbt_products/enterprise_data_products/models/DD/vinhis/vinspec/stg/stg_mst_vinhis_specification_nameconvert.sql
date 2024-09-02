with stg_mst_vinhis_specification_nameconvert as (
    select * from {{source('vinhis_db_vinspec','raw_mst_vinhis_specification_nameconvert')}}
)
select * from stg_mst_vinhis_specification_nameconvert