with
    stg_material as (
        select
            material_id, --材質ID
            material_name, --材質名
            paint_type_id, --塗料種類ID
            paint_maker_id, --塗料メーカID
            paint_uses_id, --塗料用途ID
            test_skip_flg, --品保検査スキップフラグ
            inspection_method_no, --検査法No
            viscocity_unit_id, --粘土単位ID
            matrix_name, --材質名
            color_no_3, --カラーNo_3
            color_branch_no_3, --カラーNo枝番_3
            color_no_4, --カラーNo_4
            color_branch_no_4, --カラーNo枝番_4
            paint_layer_id, --塗膜ID
            created_at, --登録日
            updated_at --変更日
        from {{ ref('stg_material') }} --材料
    ),
    stg_delivery as (
        select
            delivery_id, --納入ID
            material_id, --材質ID
            lot_no, --ロットNo
            lot_year, --ロット年度
            manufactured_date, --製造日
            created_at, --登録日
            updated_at --更新日
        from {{ ref('stg_delivery') }} --塗料納入
    ),
    stg_accept_test as (
        select
            accept_test_id, --受入検査ID
            delivery_id, --納入ID
            count, --塗料受入実施回数
            accept_id, --受入可否ID
            judge_user_flg, --合否判定ユーザフラグ
            created_at, --受入検査登録日
            updated_at --受入検査変更日
        from {{ ref('stg_accept_test') }} --受入検査
    ),
    stg_maker_result as (
        select
            maker_result_id, --メーカ検査結果ID
            accept_test_id, --受入検査ID
            test_date, --検査日
            l25, --L25
            a25, --a25
            b25, --b25
            dl25, --dL25
            da25, --da25
            db25, --db25
            de25, --dE25
            l45, --L45
            a45, --a45
            b45, --b45
            dl45, --dL45
            da45, --da45
            db45, --db45
            de45, --dE45
            l75, --L75
            a75, --a75
            b75, --b75
            dl75, --dL75
            da75, --da75
            db75, --db75
            de75, --dE75
            viscosity, --粘度
            heating_residue, --加熱残分
            ti_value, --Ti値
            ph, --pH
            hiding_power, --隠蔽力
            glossiness, --60度鏡面光沢度
            hardness_id, --鉛筆硬度ID
            adhesion, --付着性
            filtration_residue, --濾過残渣
            acid_value, --酸価
            acid_resistant, --耐酸性雨性
            surface_resistance, --表面抵抗値
            specific_gravity, --塗料比重
            density, --塗料密度
            dilution_stability_c_method, --希釈安定性C法
            cissing_count, --ハジキ件数
            dent_count, --凹み件数
            check_comments, --目視コメント
            remark, --備考
            created_at --登録日
        from {{ ref('stg_maker_result') }} --メーカー検査結果
    )
        select
            stg_material.material_id, --材質ID
            stg_material.material_name, --材質名
            stg_material.paint_type_id, --塗料種類ID
            stg_material.paint_maker_id, --塗料メーカID
            stg_material.paint_uses_id, --塗料用途ID
            stg_material.test_skip_flg, --品保検査スキップフラグ
            stg_material.inspection_method_no, --検査法No
            stg_material.viscocity_unit_id, --粘土単位ID
            stg_material.matrix_name, --材料名
            stg_material.color_no_3, --カラーNo_3
            stg_material.color_branch_no_3, --カラーNo枝番_3
            stg_material.color_no_4, --カラーNo_4
            stg_material.color_branch_no_4, --カラーNo枝番_4
            stg_material.paint_layer_id, --塗膜ID
            stg_material.created_at as material_created_at, --材質登録日
            stg_material.updated_at as material_updated_at, --材質変更日
            stg_delivery.delivery_id, --納入ID
            stg_delivery.lot_no, --ロットNo
            stg_delivery.lot_year, --ロット年度
            stg_delivery.manufactured_date, --製造日
            stg_delivery.created_at as delivery_created_at, --納入登録日
            stg_delivery.updated_at as delivery_updated_at, --納入更新日
            stg_accept_test.accept_test_id, --受入検査ID
            stg_accept_test.count, --塗料受入実施回数
            stg_accept_test.accept_id, --受入可否ID
            stg_accept_test.judge_user_flg, --合否判定ユーザフラグ
            stg_accept_test.created_at as accept_created_at, --受入検査登録日
            stg_accept_test.updated_at as accept_updated_at, --受入検査変更日
            stg_maker_result.maker_result_id, --メーカ検査結果ID
            stg_maker_result.test_date, --検査日
            stg_maker_result.l25, --L25
            stg_maker_result.a25, --a25
            stg_maker_result.b25, --b25
            stg_maker_result.dl25, --dL25
            stg_maker_result.da25, --da25
            stg_maker_result.db25, --db25
            stg_maker_result.de25, --dE25
            stg_maker_result.l45, --L45
            stg_maker_result.a45, --a45
            stg_maker_result.b45, --b45
            stg_maker_result.dl45, --dL45
            stg_maker_result.da45, --da45
            stg_maker_result.db45, --db45
            stg_maker_result.de45, --dE45
            stg_maker_result.l75, --L75
            stg_maker_result.a75, --a75
            stg_maker_result.b75, --b75
            stg_maker_result.dl75, --dL75
            stg_maker_result.da75, --da75
            stg_maker_result.db75, --db75
            stg_maker_result.de75, --dE75
            stg_maker_result.viscosity, --粘度
            stg_maker_result.heating_residue, --加熱残分
            stg_maker_result.ti_value, --Ti値
            stg_maker_result.ph, --pH
            stg_maker_result.hiding_power, --隠蔽力
            stg_maker_result.glossiness, --60度鏡面光沢度
            stg_maker_result.hardness_id, --鉛筆硬度ID
            stg_maker_result.adhesion, --付着性
            stg_maker_result.filtration_residue, --濾過残渣
            stg_maker_result.acid_value, --酸価
            stg_maker_result.acid_resistant, --耐酸性雨性
            stg_maker_result.surface_resistance, --表面抵抗値
            stg_maker_result.specific_gravity, --塗料比重
            stg_maker_result.density, --塗料密度
            stg_maker_result.dilution_stability_c_method, --希釈安定性C法
            stg_maker_result.cissing_count, --ハジキ件数
            stg_maker_result.dent_count, --凹み件数
            stg_maker_result.check_comments, --目視コメント
            stg_maker_result.remark, --備考
            stg_maker_result.created_at as maker_result_created_at --検査結果登録日
        from stg_material
        left outer join stg_delivery
        on stg_material.material_id = stg_delivery.material_id
        left outer join stg_accept_test
        on stg_delivery.delivery_id = stg_accept_test.delivery_id
        left outer join stg_maker_result
        on stg_accept_test.accept_test_id = stg_maker_result.accept_test_id