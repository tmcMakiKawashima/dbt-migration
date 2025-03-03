with
  stg_material as (
    select
      material_id, -- 材質ID
      material_name, -- 材質名
      paint_type_id, -- 塗料種類ID
      paint_maker_id, -- 塗料メーカID
      paint_uses_id, -- 塗料用途ID
      test_skip_flg, -- 品保検査スキップフラグ
      inspection_method_no, -- 検査法No
      viscocity_unit_id, -- 粘土単位ID
      matrix_name, -- 材質名
      color_no_3, -- カラーNo_3
      color_branch_no_3, -- カラーNo枝番_3
      color_no_4, -- カラーNo_4
      color_branch_no_4, -- カラーNo枝番_4
      paint_layer_id, -- 塗膜ID
      created_at, -- 登録日
      updated_at -- 変更日
    from {{ref('stg_material')}} 
  ),
  stg_material_controlband as (
    select
      control_band_id, -- 塗料管理幅ID
      material_id, -- 材質ID
      date_from, -- 適用開始日
      created_at, -- 登録日
      update_at, -- 変更日
      band_type_id, -- 管理幅分類ID
      dl25_max, -- dL25_上限幅
      dl25_min, -- dL25_下限幅
      da25_max, -- da25_上限幅
      da25_min, -- da25_下限幅
      db25_max, -- db25_上限幅
      db25_min, -- db25_下限幅
      de25_max, -- dE25_上限幅
      viscosity_max, -- 粘度_上限幅
      viscosity_min, -- 粘度_下限幅
      heating_residue_max, -- 加熱残分_上限幅
      heating_residue_min, -- 加熱残分_下限幅
      ph_max, -- pH_上限幅
      ph_min, -- pH_下限幅
      ti_value_max, -- Ti値_上限幅
      ti_value_min, -- Ti値_下限幅
      hiding_power_max, -- 白黒隠蔽_上限幅
      hiding_power_min, -- 白黒隠蔽_下限幅
      glossiness_max, -- 60度鏡面光沢度_上限幅
      glossiness_min, -- 60度鏡面光沢度_下限幅
      hardness_min, -- 鉛筆硬度_下限
      filteration_residue_max, -- 濾過残渣_上限幅
      acid_value_max, -- 酸価_上限幅
      acid_value_min, -- 酸価_下限幅
      acid_resistance_max, -- 耐酸性雨性_上限幅
      acid_resistance_min, -- 耐酸性雨性_下限幅
      surface_resistance_max, -- 表面抵抗値_上限幅
      surface_resistance_min, -- 表面抵抗値_下限幅
      dl45_max, -- dL45_上限幅
      dl45_min, -- dL45_下限幅
      da45_max, -- da45_上限幅
      da45_min, -- da45_下限幅
      db45_max, -- db45_上限幅
      db45_min, -- db45_下限幅
      de45_max, -- dE45_上限幅
      dl75_max, -- dL75_上限幅
      dl75_min, -- dL75_下限幅
      da75_max, -- da75_上限幅
      da75_min, -- da75_下限幅
      db75_max, -- db75_上限幅
      db75_min, -- db75_下限幅
      de75_max, -- dE75_上限幅
      specific_gravity_max, -- 塗料比重_上限幅
      specific_gravity_min, -- 塗料比重_下限幅
      density_max, -- 塗料密度_上限幅
      density_min, -- 塗料密度_下限幅
      dilution_stability_c_method_max, -- 希釈安定性C法_上限幅
      all_angles_flg, -- 全角度入力フラグ
      cissing_count_max, -- ハジキ件数_下限
      dent_count_max -- 凹み件数_上限
    from {{ref('stg_material_controlband')}} 
  )
 select
    stg_material.material_id, -- 材質ID
    stg_material.material_name, -- 材質名
    stg_material.paint_type_id, -- 塗料種類ID
    stg_material.paint_maker_id, -- 塗料メーカID
    stg_material.paint_uses_id, -- 塗料用途ID
    stg_material.test_skip_flg, -- 品保検査スキップフラグ
    stg_material.inspection_method_no, -- 検査法No
    stg_material.viscocity_unit_id, -- 粘土単位ID
    stg_material.matrix_name, -- 材料名
    stg_material.color_no_3, -- カラーNo_3
    stg_material.color_branch_no_3, -- カラーNo枝番_3
    stg_material.color_no_4, -- カラーNo_4
    stg_material.color_branch_no_4, -- カラーNo枝番_4
    stg_material.paint_layer_id, -- 塗膜ID
    stg_material.created_at as material_created_at, -- 材質登録日
    stg_material.updated_at as material_updated_at, -- 材質変更日
    stg_material_controlband.control_band_id, -- 塗料管理幅ID
    stg_material_controlband.date_from as control_band_date_from, -- 管理幅適用開始日
    stg_material_controlband.created_at as control_band_created_at, -- 管理幅登録日
    stg_material_controlband.update_at as control_band_updated_at, -- 管理幅変更日
    stg_material_controlband.band_type_id, -- 管理幅分類ID
    stg_material_controlband.dl25_max, -- dL25_上限幅
    stg_material_controlband.dl25_min, -- dL25_下限幅
    stg_material_controlband.da25_max, -- da25_上限幅
    stg_material_controlband.da25_min, -- da25_下限幅
    stg_material_controlband.db25_max, -- db25_上限幅
    stg_material_controlband.db25_min, -- db25_下限幅
    stg_material_controlband.de25_max, -- dE25_上限幅
    stg_material_controlband.viscosity_max, -- 粘度_上限幅
    stg_material_controlband.viscosity_min, -- 粘度_下限幅
    stg_material_controlband.heating_residue_max, -- 加熱残分_上限幅
    stg_material_controlband.heating_residue_min, -- 加熱残分_下限幅
    stg_material_controlband.ph_max, -- pH_上限幅
    stg_material_controlband.ph_min, -- pH_下限幅
    stg_material_controlband.ti_value_max, -- Ti値_上限幅
    stg_material_controlband.ti_value_min, -- Ti値_下限幅
    stg_material_controlband.hiding_power_max, -- 白黒隠蔽_上限幅
    stg_material_controlband.hiding_power_min, -- 白黒隠蔽_下限幅
    stg_material_controlband.glossiness_max, -- 60度鏡面光沢度_上限幅
    stg_material_controlband.glossiness_min, -- 60度鏡面光沢度_下限幅
    stg_material_controlband.hardness_min, -- 鉛筆硬度_下限
    stg_material_controlband.filteration_residue_max, -- 濾過残渣_上限幅
    stg_material_controlband.acid_value_max, -- 酸価_上限幅
    stg_material_controlband.acid_value_min, -- 酸価_下限幅
    stg_material_controlband.acid_resistance_max, -- 耐酸性雨性_上限幅
    stg_material_controlband.acid_resistance_min, -- 耐酸性雨性_下限幅
    stg_material_controlband.surface_resistance_max, -- 表面抵抗値_上限幅
    stg_material_controlband.surface_resistance_min, -- 表面抵抗値_下限幅
    stg_material_controlband.dl45_max, -- dL45_上限幅
    stg_material_controlband.dl45_min, -- dL45_下限幅
    stg_material_controlband.da45_max, -- da45_上限幅
    stg_material_controlband.da45_min, -- da45_下限幅
    stg_material_controlband.db45_max, -- db45_上限幅
    stg_material_controlband.db45_min, -- db45_下限幅
    stg_material_controlband.de45_max, -- dE45_上限幅
    stg_material_controlband.dl75_max, -- dL75_上限幅
    stg_material_controlband.dl75_min, -- dL75_下限幅
    stg_material_controlband.da75_max, -- da75_上限幅
    stg_material_controlband.da75_min, -- da75_下限幅
    stg_material_controlband.db75_max, -- db75_上限幅
    stg_material_controlband.db75_min, -- db75_下限幅
    stg_material_controlband.de75_max, -- dE75_上限幅
    stg_material_controlband.specific_gravity_max, -- 塗料比重_上限幅
    stg_material_controlband.specific_gravity_min, -- 塗料比重_下限幅
    stg_material_controlband.density_max, -- 塗料密度_上限幅
    stg_material_controlband.density_min, -- 塗料密度_下限幅
    stg_material_controlband.dilution_stability_c_method_max, -- 希釈安定性C法_上限幅
    stg_material_controlband.all_angles_flg, -- 全角度入力フラグ
    stg_material_controlband.cissing_count_max, -- ハジキ件数_下限
    stg_material_controlband.dent_count_max -- 凹み件数_上限
 from stg_material
  left outer join stg_material_controlband
    on stg_material.material_id = stg_material_controlband.material_id