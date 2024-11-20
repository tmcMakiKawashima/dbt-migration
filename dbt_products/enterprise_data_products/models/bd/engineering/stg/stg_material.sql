{{
  config(
    materialized='incremental',
    unique_key = ['material_id'],
    incremental_strategy = 'merge'
  )
 }}

with stg_material as (
    select
        material_id::number(10,0) as material_id, -- なし
        material_name::varchar(100) as material_name, -- なし
        paint_type_id::number(10,0) as paint_type_id, -- なし
        paint_maker_id::number(10,0) as paint_maker_id, -- なし
        paint_uses_id::number(10,0) as paint_uses_id, -- なし
        test_skip_flg::number(10,0) as test_skip_flg, -- なし
        inspection_method_no::varchar(50) as inspection_method_no, -- なし
        viscocity_unit_id::number(10,0) as viscocity_unit_id, -- なし
        created_by::varchar(50) as created_by, -- なし
        created_at::timestamp_ntz(6) as created_at, -- timestamp型
        updated_by::varchar(50) as updated_by, -- なし
        updated_at::timestamp_ntz(6) as updated_at, -- timestamp型
        material_is_hidden_id::number(10,0) as material_is_hidden_id, -- なし
        matrix_name::varchar(50) as matrix_name, -- なし
        color_no_3::varchar(3) as color_no_3, -- なし
        color_branch_no_3::varchar(10) as color_branch_no_3, -- なし
        color_no_4::varchar(4) as color_no_4, -- なし
        color_branch_no_4::varchar(10) as color_branch_no_4, -- なし
        paint_layer_id::number(10,0) as paint_layer_id, -- なし
        ldts, --B層取込日時
        row_number() over (partition by material_id order by updated_at desc, line_number desc) aggkey
    from {{ source('snowpipe_db_engineering', 'raw_ktrla0g7zz0kqe0006') }}

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}

)
select * exclude(aggkey)
from stg_material
where aggkey = 1