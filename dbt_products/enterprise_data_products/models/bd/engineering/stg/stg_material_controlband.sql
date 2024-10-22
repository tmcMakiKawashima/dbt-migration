{{
  config(
    materialized='incremental',
    unique_key = ['control_band_id'],
    incremental_strategy = 'merge'
  )
 }}

with stg_material_controlband as (
    select
        control_band_id::number(10,0) as control_band_id, -- なし
        material_id::number(10,0) as material_id, -- なし
        date_from::timestamp_ntz(6) as date_from, -- timestamp型
        created_by::varchar(50) as created_by, -- なし
        created_at::timestamp_ntz(6) as created_at, -- timestamp型
        update_by::varchar(50) as update_by, -- なし
        update_at::timestamp_ntz(6) as update_at, -- timestamp型
        band_type_id::number(10,0) as band_type_id, -- なし
        dl25_max::number(6,3) as dl25_max, -- なし
        dl25_min::number(6,3) as dl25_min, -- なし
        da25_max::number(6,3) as da25_max, -- なし
        da25_min::number(6,3) as da25_min, -- なし
        db25_max::number(6,3) as db25_max, -- なし
        db25_min::number(6,3) as db25_min, -- なし
        de25_max::number(6,3) as de25_max, -- なし
        viscosity_max::number(8,2) as viscosity_max, -- なし
        viscosity_min::number(8,2) as viscosity_min, -- なし
        heating_residue_max::number(6,3) as heating_residue_max, -- なし
        heating_residue_min::number(6,3) as heating_residue_min, -- なし
        ph_max::number(6,3) as ph_max, -- なし
        ph_min::number(6,3) as ph_min, -- なし
        ti_value_max::number(6,3) as ti_value_max, -- なし
        ti_value_min::number(6,3) as ti_value_min, -- なし
        hiding_power_max::number(6,3) as hiding_power_max, -- なし
        hiding_power_min::number(6,3) as hiding_power_min, -- なし
        glossiness_max::number(6,3) as glossiness_max, -- なし
        glossiness_min::number(6,3) as glossiness_min, -- なし
        hardness_min::number(10,0) as hardness_min, -- なし
        filteration_residue_max::number(6,3) as filteration_residue_max, -- なし
        acid_value_max::number(6,3) as acid_value_max, -- なし
        acid_value_min::number(6,3) as acid_value_min, -- なし
        acid_resistance_max::number(6,3) as acid_resistance_max, -- なし
        acid_resistance_min::number(6,3) as acid_resistance_min, -- なし
        surface_resistance_max::number(6,3) as surface_resistance_max, -- なし
        surface_resistance_min::number(6,3) as surface_resistance_min, -- なし
        dl45_max::number(6,3) as dl45_max, -- なし
        dl45_min::number(6,3) as dl45_min, -- なし
        da45_max::number(6,3) as da45_max, -- なし
        da45_min::number(6,3) as da45_min, -- なし
        db45_max::number(6,3) as db45_max, -- なし
        db45_min::number(6,3) as db45_min, -- なし
        de45_max::number(6,3) as de45_max, -- なし
        dl75_max::number(6,3) as dl75_max, -- なし
        dl75_min::number(6,3) as dl75_min, -- なし
        da75_max::number(6,3) as da75_max, -- なし
        da75_min::number(6,3) as da75_min, -- なし
        db75_max::number(6,3) as db75_max, -- なし
        db75_min::number(6,3) as db75_min, -- なし
        de75_max::number(6,3) as de75_max, -- なし
        specific_gravity_max::number(6,3) as specific_gravity_max, -- なし
        specific_gravity_min::number(6,3) as specific_gravity_min, -- なし
        density_max::number(6,3) as density_max, -- なし
        density_min::number(6,3) as density_min, -- なし
        dilution_stability_c_method_max::number(6,3) as dilution_stability_c_method_max, -- なし
        all_angles_flg::number(10,0) as all_angles_flg, -- なし
        cissing_count_max::number(10,0) as cissing_count_max, -- なし
        dent_count_max::number(10,0) as dent_count_max, -- なし
        ldts, --B層取込日時
        row_number() over (partition by control_band_id order by update_at desc, line_number desc) aggkey
    from {{ source('snowpipe_db_engineering', 'raw_ktrea0g7zz0kqe0004') }}

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}

)
select * exclude(aggkey)
from stg_material_controlband
where aggkey = 1