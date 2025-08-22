{{
    config(
       materialized='dynamic_table',
       on_configuration_change='apply',
       target_lag='15 minutes',
       snowflake_warehouse='supplydemand_wh',
       refresh_mode='incremental',
       initialize='on_create', 
       )
}}
with stg_seiyakuformat_kodomo as (
   select 
       company_member::varchar(30) as company_member,
       getudo::varchar(6) as getudo,
       restrictionname::varchar(50) as restrictionname, 
       line::varchar(3) as line,
       model::varchar(30) as model,
       dom_exp::varchar(1) as dom_exp,
       unit::varchar(10) as unit,
       body_type::varchar(10) as body_type,
       ss::varchar(4) as ss,
       subseriescode::varchar(4) as subseriescode,
       capasitycase::varchar(50) as capasitycase,
       to_number(capasity,14,3)::number(14,3) as capasity, 
       yyyymm::varchar(6) as yyyymm,
       to_number(production,14,3)::number(14,3) as production,
       to_number(upperflex,14,3)::number(14,3) as upperflex,
       ldts::timestamp_ntz(9) as ldts, 
       file_name::varchar(100) as file_name, 
       row_number() over (
            partition by
                company_member,
                getudo,
                restrictionname,
                line,
                model,
                dom_exp,
                unit,
                body_type,
                ss,
                subseriescode,
                yyyymm
            order by file_name desc,line_number desc
        ) aggkey
   from {{ source('snowpipe_db_supplydemand','raw_t_restriction_formats') }}
   ),
   stg_seiyakuformat_kodomo_max as (
   --ほぼ同時に着弾するとldtsでは最新の判断が困難な為、file_nameを使用する(現行コドモの仕様と合わせる)
   select
     getudo,
     max(file_name) as max_file_name
   from {{ source('snowpipe_db_supplydemand','raw_t_restriction_formats') }}
   group by 
     getudo 
   )
select
  stg_seiyakuformat_kodomo.* exclude(aggkey,file_name) 
from stg_seiyakuformat_kodomo
inner join stg_seiyakuformat_kodomo_max
  on stg_seiyakuformat_kodomo.getudo = stg_seiyakuformat_kodomo_max.getudo
  and stg_seiyakuformat_kodomo.file_name = stg_seiyakuformat_kodomo_max.max_file_name
where stg_seiyakuformat_kodomo.aggkey = 1
