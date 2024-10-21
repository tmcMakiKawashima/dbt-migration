{{
  config(
    materialized='incremental',
    unique_key = ['criteria_id'],
    incremental_strategy = 'merge'
  )
 }}

with stg_material_criteria as (
    select
        criteria_id::number(10,0) as criteria_id, -- なし
        material_id::number(10,0) as material_id, -- なし
        date_from::timestamp_ntz(6) as date_from, -- timestamp型
        created_by::varchar(30) as created_by, -- なし
        created_at::timestamp_ntz(6) as created_at, -- timestamp型
        updated_by::varchar(30) as updated_by, -- なし
        update_at::timestamp_ntz(6) as update_at, -- timestamp型
        viscosity::number(8,2) as viscosity, -- なし
        heating_residue::number(6,3) as heating_residue, -- なし
        ph::number(6,3) as ph, -- なし
        ti_value::number(6,3) as ti_value, -- なし
        hiding_power::number(6,3) as hiding_power, -- なし
        glossiness::number(6,3) as glossiness, -- なし
        acid_value::number(6,3) as acid_value, -- なし
        acid_resistance::number(6,3) as acid_resistance, -- なし
        surface_resistance::number(6,3) as surface_resistance, -- なし
        specific_gravity::number(6,3) as specific_gravity, -- なし
        density::number(6,3) as density, -- なし
        ldts, --B層取込日時
        row_number() over (partition by criteria_id order by update_at desc, line_number desc) aggkey
    from {{ source('snowpipe_db_engineering', 'raw_ktrea0g7zz0kqe0005') }}

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}

)
select * exclude(aggkey)
from stg_material_criteria
where aggkey = 1