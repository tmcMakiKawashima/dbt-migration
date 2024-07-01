
  
    

        create or replace transient table EDP_INFRA_SANDBOX_DB.PUBLIC.my_seventh_dbt_model
         as
        (

with source_data as (

    select 1 as id
    union all
    select null as id

)

select *
from source_data
        );
      
  