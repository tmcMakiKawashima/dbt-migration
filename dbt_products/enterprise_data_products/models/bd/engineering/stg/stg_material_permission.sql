{{ config(
       materialized ='incremental',
       unique_key = ['permission_id'],
       incremental_strategy = 'merge'
  ) }}

with stg_material_permission as (
    select
        permission_id::number(10,0) as permission_id, --なし
        material_id::number(10,0) as material_id, --なし
        permission_tmk::number(1,0) as permission_tmk, --なし
        permission_boshoku::number(1,0) as permission_boshoku, --なし
        permission_syatai::number(1,0) as permission_syatai, --なし
        permission_gifusyatai::number(1,0) as permission_gifusyatai, --なし
        permission_jidousyokki::number(1,0) as permission_jidousyokki, --なし
        permission_tmej::number(1,0) as permission_tmej, --なし
        permission_daihatsu::number(1,0) as permission_daihatsu, --なし
        permission_hino::number(1,0) as permission_hino, --なし
        created_by::varchar(50) as created_by, --なし
        created_at::timestamp_ntz(6) as created_at,  --timestamp型
        updated_by::varchar(50) as updated_by, --なし
        updated_at::timestamp_ntz(6) as updated_at,  --timestamp型
        ldts, --B層取込日時
        row_number() over (partition by permission_id order by updated_at desc, line_number desc) aggkey
    from {{ source('snowpipe_db_engineering', 'raw_ktrla0g7zz0kqe0008') }}

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}

)
select * exclude(aggkey)
from stg_material_permission
where aggkey = 1
