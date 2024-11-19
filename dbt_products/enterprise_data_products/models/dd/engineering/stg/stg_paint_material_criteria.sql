with
    stg_material as (
        select
            material_id, --材質id
            material_name, --材質名
            paint_type_id, --塗料種類id
            paint_maker_id, --塗料メーカーid
            paint_uses_id, --塗料用途id
            test_skip_flg, --品保検査スキップフラグ
            inspection_method_no, --検査法no
            viscocity_unit_id, --粘土単位id
            matrix_name, --材料名
            color_no_3, --カラーno_3
            color_branch_no_3, --カラーno枝番_3
            color_no_4, --カラーno_4
            color_branch_no_4, --カラーno枝番_4
            paint_layer_id, --塗膜id
            created_at, --材質登録日
            updated_at --材質変更日
        from {{ ref('stg_material') }} -- 材質
    ),
    stg_material_criteria as (
        select
            material_id, --材質id
            criteria_id, --塗料管理基準id
            date_from, --基準値適用開始日
            created_at, --基準値登録日
            update_at, --基準値変更日
            viscosity, --粘度
            heating_residue, --加熱残分
            ph, --ph
            ti_value, --ti値
            hiding_power, --白黒隠蔽
            glossiness, --60度鏡面光沢度
            acid_value, --酸価
            acid_resistance, --耐酸性雨性
            surface_resistance, --表面抵抗値
            specific_gravity, --塗料比重
            density --塗料密度
        from {{ ref('stg_material_criteria') }} -- 塗料基準値
    )
select
    stg_material.material_id, --材質id stg_material
    stg_material.material_name, --材質名 stg_material
    stg_material.paint_type_id, --塗料種類id stg_material
    stg_material.paint_maker_id, --塗料メーカid stg_material
    stg_material.paint_uses_id, --塗料用途id stg_material
    stg_material.test_skip_flg, --品保検査スキップフラグ stg_material
    stg_material.inspection_method_no, --検査法no stg_material
    stg_material.viscocity_unit_id, --粘土単位id stg_material
    stg_material.matrix_name, --材料名 stg_material
    stg_material.color_no_3, --カラーno_3 stg_material
    stg_material.color_branch_no_3, --カラーno枝番_3 stg_material
    stg_material.color_no_4, --カラーno_4 stg_material
    stg_material.color_branch_no_4, --カラーno枝番_4 stg_material
    stg_material.paint_layer_id, --塗膜id stg_material
    stg_material.created_at as material_created_at, --材質登録日 stg_material
    stg_material.updated_at as material_updated_at, --材質変更日 stg_material
    stg_material_criteria.criteria_id, --塗料管理基準id stg_material_criteria
    stg_material_criteria.date_from as criteria_date_from, --基準値適用開始日 stg_material_criteria
    stg_material_criteria.created_at as criteria_created_at, --基準値登録日 stg_material_criteria
    stg_material_criteria.update_at as criteria_updated_at, --基準値変更日 stg_material_criteria
    stg_material_criteria.viscosity, --粘度 stg_material_criteria
    stg_material_criteria.heating_residue, --加熱残分 stg_material_criteria
    stg_material_criteria.ph, --ph stg_material_criteria
    stg_material_criteria.ti_value, --ti値 stg_material_criteria
    stg_material_criteria.hiding_power, --白黒隠蔽 stg_material_criteria
    stg_material_criteria.glossiness, --60度鏡面光沢度 stg_material_criteria
    stg_material_criteria.acid_value, --酸価 stg_material_criteria
    stg_material_criteria.acid_resistance, --耐酸性雨性 stg_material_criteria
    stg_material_criteria.surface_resistance, --表面抵抗値 stg_material_criteria
    stg_material_criteria.specific_gravity, --塗料比重 stg_material_criteria
    stg_material_criteria.density --塗料密度 stg_material_criteria
from stg_material
left outer join stg_material_criteria
    on stg_material.material_id = stg_material_criteria.material_id