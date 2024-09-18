{{ 
  config(
    materialized='incremental',
    unique_key = ['ftr_no'],
    incremental_strategy = 'merge'
  )
 }}

with stg_shijoho as (
    select
        ftr_no::varchar(14) as ftr_no, --なし
        tecrepo_no::varchar(30) as tecrepo_no, --なし
        tecrepo_no_trimed::varchar(30) as tecrepo_no_trimed, --なし
        lo_date::varchar(8) as lo_date, --なし
        model_major_cls_code::varchar(2) as model_major_cls_code, --なし
        sms_veh_code::varchar(4) as sms_syasyu_cd, --なし
        hi_kt_tqnet::varchar(90) as hi_kt_tqnet, --なし
        sales_katashiki_60::varchar(60) as sales_katashiki_60, --なし
        eng_no::varchar(7) as eng_no, --なし
        eg_kt7::varchar(7) as eg_kt7, --なし
        tm_type::varchar(6) as tm_type, --なし
        rdf_type::varchar(3) as rdf_type, --なし
        eng_plnt_code::varchar(2) as eng_plnt_code, --なし
        tire_maker::varchar(2) as tire_maker, --なし
        production_area_cls::varchar(1) as production_area_cls, --なし
        production_country_code::varchar(3) as production_country_code, --なし
        onec_line_code::varchar(2) as ichiken_linecd, --なし
        onec_date::varchar(8) as ichikenymd, --なし
        endc_line_code::varchar(2) as syuken_linecd, --なし
        endc_date::varchar(8) as syukenymd, --なし
        pack_line_code::varchar(2) as konpo_linecd, --なし
        pack_date::varchar(8) as konpoymd, --なし
        ident_line_code::varchar(2) as ident_line_code, --なし
        pack_form::varchar(1) as pack_form, --なし
        export_cls::varchar(1) as export_cls, --なし
        region_cls::varchar(1) as region_cls, --なし
        use_cls::varchar(1) as use_cls, --なし
        dest_code::varchar(3) as dest_code, --なし
        deliv_deal_code::varchar(5) as haisya_dlrcd, --なし
        deliv_date::varchar(8) as haisyaymd, --なし
        reg_state_code::varchar(3) as reg_state_code, --なし
        reg_country_code::varchar(5) as reg_country_code, --なし
        reg_deal_code::varchar(8) as reg_deal_code, --なし
        veh_reg_date::varchar(8) as veh_reg_date, --なし
        veh_name_code::varchar(2) as veh_name_code, --なし
        ext_color_code::varchar(4) as ext_color_code, --なし
        int_code::varchar(4) as int_code, --なし
        model_veh_code::varchar(4) as model_veh_code, --なし
        frame_cls::varchar(6) as frmkbn, --なし
        frame_no::varchar(7) as frmno, --なし
        vin_17::varchar(17) as vin_17, --なし
        vin_my::varchar(1) as my, --なし
        imp_rank::varchar(1) as imp_rank, --なし
        info_kind_code::varchar(2) as info_kind_code, --なし
        ftr_ofp::varchar(15) as ftr_ofp, --なし
        ftr_compo_code::varchar(5) as ftr_compo_code, --なし
        ftr_pheno_code::varchar(3) as ftr_pheno_code, --なし
        ftr_repair_date::varchar(8) as ftr_repair_date, --なし
        ftr_deal_code::varchar(5) as ftr_deal_code, --なし
        ftr_mil_km::number(7) as ftr_mil_km, --なし
        ftr_twc_no::varchar(9) as ftr_twc_no, --なし
        fh_pheno_code::varchar(1) as fh_pheno_code, --なし
        fh_cause_code::varchar(2) as fh_cause_code, --なし
        confirme_exist::varchar(1) as confirme_exist, --なし
        report_date::varchar(8) as report_date, --なし
        cr_info_no::varchar(16) as cr_info_no, --なし
        other_vehicles_num::number(4) as other_vehicles_num, --なし
        rts_no::varchar(9) as rts_no, --なし
        first_ftr_flg::varchar(1) as first_ftr_flg, --なし
        first_report_flg::varchar(1) as first_report_flg, --なし
        main_dist_not_flg::varchar(1) as main_dist_not_flg, --なし
        distrib_not_flg::varchar(1) as distrib_not_flg, --なし
        fcr_parts_flg::varchar(1) as fcr_parts_flg, --なし
        sum_transl_atmn_flg::varchar(1) as sum_transl_atmn_flg, --なし
        sum_comment_at_tranl_flg::varchar(1) as sum_comment_at_tranl_flg, --なし
        sum_comment_jp::varchar(750) as sum_comment_jp, --なし
        sum_comment_us::varchar(750) as sum_comment_us, --なし
        sum_comment_zh::varchar(750) as sum_comment_zh, --なし
        ftr_recept_date::timestamp as ftr_recept_date,  --timestamp型
        duplication_cls::varchar(1) as duplication_cls, --なし
        depuli_minfo_no::varchar(14) as depuli_minfo_no, --なし
        fcr_issue_typ::varchar(1) as fcr_issue_typ, --なし
        ftr_recept_charge_id::varchar(11) as ftr_recept_charge_id, --なし
        ftr_recept_charge_date::timestamp as ftr_recept_charge_date, --timestamp型
        ftr_proc_charge_id::varchar(11) as ftr_proc_charge_id, --なし
        ftr_proc_charge_date::timestamp as ftr_proc_charge_date,  --timestamp型
        ftr_proc_recognize_id::varchar(11) as ftr_proc_recognize_id, --なし
        ftr_proc_recognize_date::timestamp as ftr_proc_recognize_date,  --timestamp型
        ftr_proc_via_person1_id::varchar(11) as ftr_proc_via_person1_id, --なし
        ftr_proc_via_person1_date::timestamp as ftr_proc_via_person1_date,  --timestamp型
        ftr_proc_via_person2_id::varchar(11) as ftr_proc_via_person2_id, --なし
        ftr_proc_via_person2_date::timestamp as ftr_proc_via_person2_date,  --timestamp型
        ftr_proc_via_person3_id::varchar(11) as ftr_proc_via_person3_id, --なし
        ftr_proc_via_person3_date::timestamp as ftr_proc_via_person3_date,  --timestamp型
        outside_distrib_date::timestamp as outside_distrib_date,  --timestamp型
        ftr_proc_g_cmpny_code::varchar(7) as ftr_proc_g_cmpny_code, --なし
        ftr_proc_g_div_code::varchar(5) as ftr_proc_g_div_code, --なし
        outside_distrib_flg::varchar(1) as outside_distrib_flg, --なし
        ftr_match_flg::varchar(1) as ftr_match_flg, --なし
        old_ftr_no::varchar(14) as old_ftr_no, --なし
        img_joint_flg::varchar(1) as img_joint_flg, --なし
        rev_ang_cls::varchar(1) as rev_ang_cls, --なし
        open_flg::varchar(1) as open_flg, --なし
        former_info_je_cls::varchar(1) as former_info_je_cls, --なし
        ftr_sts::varchar(2) as ftr_sts, --なし
        first_input_flg::varchar(1) as first_input_flg, --なし
        vhist_warra_set_cls::varchar(1) as vhist_warra_set_cls, --なし
        parts_set_sts::varchar(1) as parts_set_sts, --なし
        ftr_related_flg::varchar(1) as ftr_related_flg, --なし
        brand_cls::varchar(1) as brand_cls, --なし
        veh_name::varchar(84) as syamei, --なし
        veh_katashiki::varchar(15) as syadai_kt, --なし
        popular_name::varchar(60) as popular_name, --なし
        classification::varchar(45) as classification, --なし
        veh_use_name::varchar(42) as veh_use_name, --なし
        veh_body_type::varchar(39) as veh_body_type, --なし
        prime_mober_katashiki::varchar(12) as prime_mober_katashiki, --なし
        prime_mober_displacement::varchar(6) as prime_mober_displacement, --なし
        certificate_cls::varchar(1) as certificate_cls, --なし
        designation_no::varchar(7) as designation_no, --なし
        classification_no::varchar(4) as classification_no, --なし
        cate_vehicle::varchar(1) as cate_vehicle, --なし
        cate_service::varchar(1) as cate_service, --なし
        cate_accessories::varchar(1) as cate_accessories, --なし
        cate_supply_parts::varchar(1) as cate_supply_parts, --なし
        accident_injured_flg::varchar(1) as accident_injured_flg, --なし
        cpsl_flg::varchar(1) as cpsl_flg, --なし
        db_user_id_tqnet::varchar(11) as db_user_id_tqnet, --なし
        db_proc_id_tqnet::varchar(8) as db_proc_id_tqnet, --なし
        db_insert_time_tqnet::timestamp as db_insert_time_tqnet,  --timestamp型
        db_update_time_tqnet::timestamp as db_update_time_tqnet,  --timestamp型
        update_cls::varchar(1) as update_cls, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp as mttime, --timestamp型
        _fivetran_synced::timestamp as ldts --timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0714ftr_info') }}
     where _fivetran_deleted = 'FALSE'

{% if is_incremental() %}
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * from stg_shijoho