{{ config(
      materialized='incremental',
      unique_key = ['traceability_id','module_id'],
      incremental_strategy = 'merge'
   ) }}

with stg_denchijoho_trm_kojoiotpf as (
    select
        rtrim(traceability_id,' 　')::varchar(30) as traceability_id,  -- 右blank
        rtrim(module_id,' 　')::varchar(30) as module_id,  -- 右blank
        rtrim(module_manufacturing_date,' 　')::varchar(20) as module_manufacturing_date,  -- 右blank
        rtrim(manufacturer_cd,' 　')::varchar(4) as manufacturer_cd,  -- 右blank
        rtrim(receive_file_name,' 　')::varchar(200) as receive_file_name,  -- 右blank
        try_to_timestamp_ntz(receive_date , 'yyyy-mm-dd hh24:mi:ss.ff6') as receive_date,  -- timestamp
        try_to_boolean(delete_flag) as delete_flag,  -- boolean
        try_to_timestamp_ntz(regist_date , 'yyyy-mm-dd hh24:mi:ss.ff6') as regist_date,  -- timestamp
        try_to_timestamp_ntz(update_date , 'yyyy-mm-dd hh24:mi:ss.ff6') as update_date,  -- timestamp
        ldts,
        row_number() over(partition by traceability_id, module_id order by ldts desc, line_number desc) aggkey
    from {{ source('snowpipe_db_manufacturing', 'raw_iotpmcbtinftrm') }}
           
  {% if is_incremental() %}
      where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_denchijoho_trm_kojoiotpf
where aggkey = 1