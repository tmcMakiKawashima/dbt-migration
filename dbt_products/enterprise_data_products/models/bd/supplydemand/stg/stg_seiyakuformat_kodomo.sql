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
       company_member as company_member,
       getudo as getudo,
       restrictionname as restrictionname, 
       line as line,
       model as model,
       dom_exp as dom_exp,
       unit as unit,
       body_type as body_type,
       ss as ss,
       subseriescode as subseriescode,
       capasitycase as capasitycase,
       to_number(capasity,14,3) as apasity, 
       yyyymm as yyyymm,
       to_number(production,14,3) as roduction,
       to_number(upperflex,14,3) as upperflex,
       ldts as ldts,
       file_name as file_name, 
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
     max(file_name) as max_ldts
   from {{ source('snowpipe_db_supplydemand','raw_t_restriction_formats') }}
   group by 
     getudo 
   )

   select
     stg_seiyakuformat_kodomo.* 
     exclude(aggkey,file_name) 
   from stg_seiyakuformat_kodomo
   inner join stg_seiyakuformat_kodomo_max
     on stg_seiyakuformat_kodomo.getudo = stg_seiyakuformat_kodomo_max.getudo
     and stg_seiyakuformat_kodomo.ldts = stg_seiyakuformat_kodomo_max.max_ldts
   where stg_seiyakuformat_kodomo.aggkey = 1
