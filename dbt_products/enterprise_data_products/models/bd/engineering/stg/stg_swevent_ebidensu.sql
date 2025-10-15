{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}
-- 洗い替えであるため、pre_hookで全件削除を行う。

with stg_swevent_ebidensu as (
    select
        eventno::varchar(9) as eventno,
        syasyu::varchar(4) as syasyu,
        eventmei::varchar(25) as eventmei,
        syonintime::varchar(17) as syonintime,
        seppenhinkou::varchar(1) as seppenhinkou,
        seppensyaryohiki::varchar(1) as seppensyaryohiki,
        evidenceumu::varchar(1) as evidenceumu,
        systorokutime::timestamp_ntz as systorokutime,
        systorokukaisyacode::varchar(5) as systorokukaisyacode,
        systorokuuserid::varchar(20) as systorokuuserid,
        systorokuaplid::varchar(25) as systorokuaplid,
        syskosintime::timestamp_ntz as syskosintime,
        syskosinkaisyacode::varchar(5) as syskosinkaisyacode,
        syskosinuserid::varchar(20) as syskosinuserid,
        syskosinaplid::varchar(25) as syskosinaplid,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_ogg_aisac_osqaeg0100db20', 'raw_cqa68jeventmtnaiyo') }}
    where _fivetran_deleted = 'false'
)
select * from stg_swevent_ebidensu
