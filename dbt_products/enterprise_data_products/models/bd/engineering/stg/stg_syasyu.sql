{{ 
  config(
    materialized='incremental',
    unique_key = ['syasyu'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    " -- 全件洗い替えであるため
  )
 }}

with stg_syasyu as (
    select
        syasyu::varchar(4) as syasyu,
        sigokbn::varchar(2) as sigokbn,
        unitkbn::varchar(2) as unitkbn,
        unitbunrui::varchar(2) as unitbunrui,
        unitsyurui::varchar(2) as unitsyurui,
        tantogaisya::varchar(2) as tantogaisya,
        kokakbn::varchar(2) as kokakbn,
        haisikbn::varchar(2) as haisikbn,
        seisikikbn::varchar(2) as seisikikbn,
        syukan::varchar(2) as syukan,
        gc::varchar(2) as gc,
        daihyokata::varchar(7) as daihyokata,
        setteitime::varchar(16) as setteitime,
        haisitime::varchar(16) as haisitime,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp22syasyu') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syasyu