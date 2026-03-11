{{
    config (
        materialized = 'incremental',
        unique_key = ['data_id', 'pro_key_cd', 'trace_tag_cd','value'],        
        incremental_strategy = 'merge',
        post_hook ="
            {% if is_incremental() %}
              update {{ this }} as t
              set t.delflg = true, t.ldts = current_timestamp
              from (
              select pro_key_cd,trace_tag_cd,value,
                row_number() over (
                  partition by
                      pro_key_cd,
                      trace_tag_cd
                  order by
                      __updated_at desc
              ) aggkey 
              from {{ this }}
              ) as s
                where t.pro_key_cd = s.pro_key_cd 
                and t.trace_tag_cd = s.trace_tag_cd
                and t.value != s.value
                and aggkey = 1
                and t.delflg = false;
            {% endif %}  
        "
    )
}}
-- 更新前のデータを論理削除するためhookの実装

with stg_jm41_tracedata_iotpf as (
    select
        trim(data_id, ' 　')::varchar(19) as data_id,
        trim(line, ' 　')::varchar(1) as line,
        trim(sf_item_name, ' 　')::varchar(20) as sf_item_name,
        trim(pro_tag_cd, ' 　')::varchar(12) as pro_tag_cd,
        trim(pro_tag_name, ' 　')::varchar(50) as pro_tag_name,
        trim(pro_key_cd, ' 　')::varchar(16) as pro_key_cd,
        trim(pro_serial_cd, ' 　')::varchar(30) as pro_serial_cd,
        trim(trace_tag_cd, ' 　')::varchar(12) as trace_tag_cd,
        trim(trace_tag_name, ' 　')::varchar(80) as trace_tag_name,
        trim(tag_type, ' 　')::varchar(1) as tag_type,
        trim(trace_key_cd, ' 　')::varchar(16) as trace_key_cd,
        trim(value, ' 　')::varchar(1000) as value,
        trim(unit, ' 　')::varchar(10) as unit,
        to_timestamp_ntz(trim(org_date_time, ' 　'))::timestamp_ntz(6) as org_date_time,
        to_timestamp_ntz(trim(rec_date_time, ' 　'))::timestamp_ntz(6) as rec_date_time,
        to_timestamp_ntz(trim(expire_date, ' 　'))::timestamp_ntz(6) as expire_date,
        to_timestamp_ntz(trim(his_create_date, ' 　'))::timestamp_ntz(6) as his_create_date,
        to_timestamp_ntz(trim(__created_at, ' 　'))::timestamp_ntz(6) as __created_at,
        to_timestamp_ntz(trim(__updated_at, ' 　'))::timestamp_ntz(6) as __updated_at,
        false::boolean as delflg,
        ldts,
        row_number() over (
            partition by
                data_id,
                pro_key_cd,
                trace_tag_cd,
                value
            order by
                ldts desc,
                line_number desc
        ) aggkey
    from {{ ref('extract_iotalcjm41g4tra') }}

    {% if is_incremental() %}
        where ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey)
from stg_jm41_tracedata_iotpf
where aggkey = 1

