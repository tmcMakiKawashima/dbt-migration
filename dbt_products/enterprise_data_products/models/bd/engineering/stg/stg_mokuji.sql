{{
  config(
    materialized='incremental',
    unique_key = ['syasyu32', 'syasyu_cd', 'kumitate', 'bui', 'kosyokt', 'vari', 'hikikey', 'torokujunk', 'spkbn', 'hikisiyo'],
    incremental_strategy = 'merge'
  )
}}

with stg_mokuji as (
    select
        syasyu32::varchar(2) as syasyu32,
        syasyu::varchar(4) as syasyu_cd,
        kumitate::varchar(4) as kumitate,
        bui::varchar(2) as bui,
        kata::varchar(20) as kosyokt,
        spkbn::varchar(1) as spkbn,
        vari::varchar(2) as vari,
        torokujunk::varchar(9) as torokujunk,
        torokujunm::varchar(9) as torokujunm,
        mttime::varchar(16) as mttime,
        hikikey::varchar(50) as hikikey,
        hikisiyo::varchar(250) as hikisiyo,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp02shinmokuji') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{this}})
    {% endif %}

)
select * from stg_mokuji