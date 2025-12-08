{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = ['sfkey']
        
    )
}}

with stg_jfy1_sfbase_history_iotpf_kojoiot_subaru as (
    select
        trim(sfkey, ' 　')::varchar(16) as sfkey,  -- 右左ブランク
        trim(vin_type2, ' 　')::varchar(2) as vin_type2,  -- 右左ブランク
        trim(vin_type, ' 　')::varchar(1) as vin_type,  -- 右左ブランク
        trim(vin_wmi, ' 　')::varchar(3) as vin_wmi,  -- 右左ブランク
        trim(vin_vds, ' 　')::varchar(6) as vin_vds,  -- 右左ブランク
        trim(vin_kata, ' 　')::varchar(9) as vin_kata,  -- 右左ブランク
        trim(vin_fr67, ' 　')::varchar(1) as vin_fr67,  -- 右左ブランク
        trim(vin_my, ' 　')::varchar(1) as vin_my,  -- 右左ブランク
        trim(maker, ' 　')::varchar(4) as maker,  -- 右左ブランク
        trim(sno, ' 　')::varchar(2) as sno,  -- 右左ブランク
        trim(odr_type, ' 　')::varchar(1) as odr_type,  -- 右左ブランク
        trim(dfsc, ' 　')::varchar(5) as dfsc,  -- 右左ブランク
        trim(lo_date, ' 　')::varchar(8) as lo_date,  -- 右左ブランク
        trim(pack_month, ' 　')::varchar(6) as pack_month,  -- 右左ブランク
        trim(car_name, ' 　')::varchar(2) as car_name,  -- 右左ブランク
        trim(figure, ' 　')::varchar(1) as figure,  -- 右左ブランク
        trim(dest_type, ' 　')::varchar(2) as dest_type,  -- 右左ブランク
        trim(gov_aprvl, ' 　')::varchar(1) as gov_aprvl,  -- 右左ブランク
        trim(int_code, ' 　')::varchar(4) as int_code,  -- 右左ブランク
        trim(ext_code, ' 　')::varchar(4) as ext_code,  -- 右左ブランク
        trim(prd_week, ' 　')::varchar(2) as prd_week,  -- 右左ブランク
        trim(prdctn_sfx, ' 　')::varchar(2) as prdctn_sfx,  -- 右左ブランク
        trim(sales_sfx, ' 　')::varchar(2) as sales_sfx,  -- 右左ブランク
        trim(import_duty, ' 　')::varchar(1) as import_duty,  -- 右左ブランク
        trim(kata_code, ' 　')::varchar(5) as kata_code,  -- 右左ブランク
        trim(katashiki, ' 　')::varchar(20) as katashiki,  -- 右左ブランク
        trim(ctlkata, ' 　')::varchar(20) as ctlkata,  -- 右左ブランク
        trim(lo_katacode, ' 　')::varchar(5) as lo_katacode,  -- 右左ブランク
        trim(lo_kata, ' 　')::varchar(20) as lo_kata,  -- 右左ブランク
        trim(eng_b_kata, ' 　')::varchar(5) as eng_b_kata,  -- 右左ブランク
        trim(mot_b_kata, ' 　')::varchar(5) as mot_b_kata,  -- 右左ブランク
        trim(mot_b_katarr, ' 　')::varchar(5) as mot_b_katarr,  -- 右左ブランク
        trim(receipt_type, ' 　')::varchar(3) as receipt_type,  -- 右左ブランク
        trim(kd_lot, ' 　')::varchar(8) as kd_lot,  -- 右左ブランク
        trim(asd_frmstamp, ' 　')::varchar(17) as asd_frmstamp,  -- 右左ブランク
        trim(asd_vinno, ' 　')::varchar(17) as asd_vinno,  -- 右左ブランク
        trim(car_family, ' 　')::varchar(4) as car_family,  -- 右左ブランク
        trim(prdreq_month, ' 　')::varchar(6) as prdreq_month,  -- 右左ブランク
        trim(brand, ' 　')::varchar(1) as brand,  -- 右左ブランク
        trim(katashiki2, ' 　')::varchar(20) as katashiki2,  -- 右左ブランク
        trim(dum_v, ' 　')::varchar(1) as dum_v,  -- 右左ブランク
        trim(spec001_200, ' 　')::varchar(200) as spec001_200,  -- 右左ブランク
        trim(dest_code, ' 　')::varchar(5) as dest_code,  -- 右左ブランク
        trim(dest, ' 　')::varchar(20) as dest,  -- 右左ブランク
        trim(psc, ' 　')::varchar(2) as psc,  -- 右左ブランク
        trim(plant_code, ' 　')::varchar(1) as plant_code,  -- 右左ブランク
        trim(dummy_spec, ' 　')::varchar(71) as dummy_spec,  -- 右左ブランク
        trim(tecs_odrno, ' 　')::varchar(12) as tecs_odrno,  -- 右左ブランク
        trim(tecs_kata, ' 　')::varchar(25) as tecs_kata,  -- 右左ブランク
        trim(tecs_maker, ' 　')::varchar(5) as tecs_maker,  -- 右左ブランク
        trim(tecs_dealer, ' 　')::varchar(5) as tecs_dealer,  -- 右左ブランク
        trim(equipment_line, ' 　')::varchar(2) as equipment_line,  -- 右左ブランク
        trim(approval_no2_flag, ' 　')::varchar(1) as approval_no2_flag,  -- 右左ブランク
        trim(vin_stop_mark_front, ' 　')::varchar(1) as vin_stop_mark_front,  -- 右左ブランク
        trim(vin_stop_mark_rear, ' 　')::varchar(1) as vin_stop_mark_rear,  -- 右左ブランク
        trim(namc_reference_no, ' 　')::varchar(7) as namc_reference_no,  -- 右左ブランク
        trim(dum_vsect, ' 　')::varchar(41) as dum_vsect,  -- 右左ブランク
        trim(spec201_400, ' 　')::varchar(200) as spec201_400,  -- 右左ブランク
        trim(spec401_600, ' 　')::varchar(200) as spec401_600,  -- 右左ブランク
        trim(spec601_800, ' 　')::varchar(200) as spec601_800,  -- 右左ブランク
        trim(spec801_999, ' 　')::varchar(199) as spec801_999,  -- 右左ブランク
        trim(dummy, ' 　')::varchar(1) as dummy,  -- 右左ブランク
        trim(bdline, ' 　')::varchar(1) as bdline,  -- 右左ブランク
        trim(proc_code, ' 　')::varchar(2) as proc_code,  -- 右左ブランク
        trim(bctype, ' 　')::varchar(1) as bctype,  -- 右左ブランク
        trim(theft_lbl, ' 　')::varchar(1) as theft_lbl,  -- 右左ブランク
        trim(sub_frcode, ' 　')::varchar(1) as sub_frcode,  -- 右左ブランク
        trim(sub_bdcode, ' 　')::varchar(1) as sub_bdcode,  -- 右左ブランク
        trim(nofrno_flg, ' 　')::varchar(1) as nofrno_flg,  -- 右左ブランク
        trim(vehcl_type, ' 　')::varchar(1) as vehcl_type,  -- 右左ブランク
        trim(fr_line, ' 　')::varchar(1) as fr_line,  -- 右左ブランク
        trim(fin_line, ' 　')::varchar(1) as fin_line,  -- 右左ブランク
        trim(fin_tp, ' 　')::varchar(2) as fin_tp,  -- 右左ブランク
        trim(copy_flg, ' 　')::varchar(1) as copy_flg,  -- 右左ブランク
        trim(dollylocks, ' 　')::varchar(20) as dollylocks,  -- 右左ブランク
        trim(dolly_condit, ' 　')::varchar(1) as dolly_condit,  -- 右左ブランク
        trim(chassis_line, ' 　')::varchar(1) as chassis_line,  -- 右左ブランク
        trim(bat_bdline, ' 　')::varchar(1) as bat_bdline,  -- 右左ブランク
        trim(w_ctrl_s, ' 　')::varchar(1) as w_ctrl_s,  -- 右左ブランク
        trim(ast_bdodr_s, ' 　')::varchar(1) as ast_bdodr_s,  -- 右左ブランク
        trim(vin_editor_s, ' 　')::varchar(1) as vin_editor_s,  -- 右左ブランク
        trim(splprt_type, ' 　')::varchar(2) as splprt_type,  -- 右左ブランク
        trim(kd_type, ' 　')::varchar(1) as kd_type,  -- 右左ブランク
        trim(oem_type, ' 　')::varchar(1) as oem_type,  -- 右左ブランク
        trim(bridge_prod_type, ' 　')::varchar(1) as bridge_prod_type,  -- 右左ブランク
        trim(vehicle_ctg_code, ' 　')::varchar(2) as vehicle_ctg_code,  -- 右左ブランク
        trim(dum_alc, ' 　')::varchar(52) as dum_alc,  -- 右左ブランク
        trim(asmline, ' 　')::varchar(1) as asmline,  -- 右左ブランク
        trim(paintline, ' 　')::varchar(1) as paintline,  -- 右左ブランク
        trim(fbltype, ' 　')::varchar(1) as fbltype,  -- 右左ブランク
        trim(prg_mngflg, ' 　')::varchar(1) as prg_mngflg,  -- 右左ブランク
        trim(gateptn, ' 　')::varchar(1) as gateptn,  -- 右左ブランク
        trim(gateno, ' 　')::varchar(2) as gateno,  -- 右左ブランク
        trim(convrt_flg, ' 　')::varchar(3) as convrt_flg,  -- 右左ブランク
        trim(sch_date, ' 　')::varchar(8) as sch_date,  -- 右左ブランク
        trim(linename, ' 　')::varchar(1) as linename,  -- 右左ブランク
        trim(clr_lot, ' 　')::varchar(2) as clr_lot,  -- 右左ブランク
        trim(tecs_info, ' 　')::varchar(15) as tecs_info,  -- 右左ブランク
        trim(dum_sch1, ' 　')::varchar(1) as dum_sch1,  -- 右左ブランク
        trim(delivr_regn, ' 　')::varchar(3) as delivr_regn,  -- 右左ブランク
        trim(dlr_odrno, ' 　')::varchar(17) as dlr_odrno,  -- 右左ブランク
        trim(cust_flg, ' 　')::varchar(2) as cust_flg,  -- 右左ブランク
        trim(alloc_flg, ' 　')::varchar(2) as alloc_flg,  -- 右左ブランク
        trim(cust_inf, ' 　')::varchar(2) as cust_inf,  -- 右左ブランク
        trim(dlr_name, ' 　')::varchar(17) as dlr_name,  -- 右左ブランク
        trim(wrap, ' 　')::varchar(3) as wrap,  -- 右左ブランク
        trim(wrap_flg, ' 　')::varchar(1) as wrap_flg,  -- 右左ブランク
        trim(carryin_dest, ' 　')::varchar(8) as carryin_dest,  -- 右左ブランク
        trim(dum_cust, ' 　')::varchar(5) as dum_cust,  -- 右左ブランク
        trim(sch_sndflg, ' 　')::varchar(1) as sch_sndflg,  -- 右左ブランク
        trim(temp_seqflg, ' 　')::varchar(1) as temp_seqflg,  -- 右左ブランク
        trim(fix_seqflg, ' 　')::varchar(1) as fix_seqflg,  -- 右左ブランク
        trim(rej_flg, ' 　')::varchar(1) as rej_flg,  -- 右左ブランク
        trim(carryfwd_flg, ' 　')::varchar(1) as carryfwd_flg,  -- 右左ブランク
        trim(seqfl_ln, ' 　')::varchar(1) as seqfl_ln,  -- 右左ブランク
        trim(ltadd_code, ' 　')::varchar(10) as ltadd_code,  -- 右左ブランク
        trim(chas_rej_flg, ' 　')::varchar(1) as chas_rej_flg,  -- 右左ブランク
        trim(bd_resnd_flg, ' 　')::varchar(1) as bd_resnd_flg,  -- 右左ブランク
        trim(ch_resnd_flg, ' 　')::varchar(1) as ch_resnd_flg,  -- 右左ブランク
        trim(dum_host, ' 　')::varchar(31) as dum_host,  -- 右左ブランク
        trim(int_deliv, ' 　')::varchar(3) as int_deliv,  -- 右左ブランク
        trim(ecas, ' 　')::varchar(16) as ecas,  -- 右左ブランク
        trim(vl_route_code, ' 　')::varchar(2) as vl_route_code,  -- 右左ブランク
        trim(vl_nextdest_code, ' 　')::varchar(5) as vl_nextdest_code,  -- 右左ブランク
        trim(dum_sys, ' 　')::varchar(17) as dum_sys,  -- 右左ブランク
        trim(seqno, ' 　')::varchar(5) as seqno,  -- 右左ブランク
        trim(fix_seqno, ' 　')::varchar(6) as fix_seqno,  -- 右左ブランク
        trim(fix_bdseq, ' 　')::varchar(8) as fix_bdseq,  -- 右左ブランク
        trim(fix_paintseq, ' 　')::varchar(8) as fix_paintseq,  -- 右左ブランク
        trim(fix_asmseq, ' 　')::varchar(8) as fix_asmseq,  -- 右左ブランク
        trim(seqno_date, ' 　')::varchar(8) as seqno_date,  -- 右左ブランク
        trim(proc_qty, ' 　')::varchar(4) as proc_qty,  -- 右左ブランク
        trim(asmseq_date, ' 　')::varchar(8) as asmseq_date,  -- 右左ブランク
        trim(tmp_chseqno, ' 　')::varchar(6) as tmp_chseqno,  -- 右左ブランク
        trim(fix_chseqno, ' 　')::varchar(6) as fix_chseqno,  -- 右左ブランク
        trim(fixc_chseqno, ' 　')::varchar(8) as fixc_chseqno,  -- 右左ブランク
        trim(spldst_seqno, ' 　')::varchar(8) as spldst_seqno,  -- 右左ブランク
        trim(splsrc_seqno, ' 　')::varchar(8) as splsrc_seqno,  -- 右左ブランク
        trim(dum_seq, ' 　')::varchar(109) as dum_seq,  -- 右左ブランク
        trim(ship_prty_rank, ' 　')::varchar(1) as ship_prty_rank,  -- 右左ブランク
        trim(pio_opt, ' 　')::varchar(1) as pio_opt,  -- 右左ブランク
        trim(load_port_code, ' 　')::varchar(5) as load_port_code,  -- 右左ブランク
        trim(ship_assign, ' 　')::varchar(1) as ship_assign,  -- 右左ブランク
        trim(ship_org_etd, ' 　')::varchar(8) as ship_org_etd,  -- 右左ブランク
        trim(dum_exp_info, ' 　')::varchar(84) as dum_exp_info,  -- 右左ブランク
        trim(approval, ' 　')::varchar(21) as approval,  -- 右左ブランク
        trim(maxweight, ' 　')::varchar(5) as maxweight,  -- 右左ブランク
        trim(maxconbi, ' 　')::varchar(5) as maxconbi,  -- 右左ブランク
        trim(fr_axleload, ' 　')::varchar(4) as fr_axleload,  -- 右左ブランク
        trim(rr_axleload, ' 　')::varchar(4) as rr_axleload,  -- 右左ブランク
        trim(fr_tiresize, ' 　')::varchar(14) as fr_tiresize,  -- 右左ブランク
        trim(rr_tiresize, ' 　')::varchar(14) as rr_tiresize,  -- 右左ブランク
        trim(fr_rimsize, ' 　')::varchar(11) as fr_rimsize,  -- 右左ブランク
        trim(rr_rimsize, ' 　')::varchar(11) as rr_rimsize,  -- 右左ブランク
        trim(fr_tireprsr, ' 　')::varchar(2) as fr_tireprsr,  -- 右左ブランク
        trim(rr_tireprsr, ' 　')::varchar(2) as rr_tireprsr,  -- 右左ブランク
        trim(trans, ' 　')::varchar(6) as trans,  -- 右左ブランク
        trim(axle, ' 　')::varchar(4) as axle,  -- 右左ブランク
        trim(engine_kata, ' 　')::varchar(8) as engine_kata,  -- 右左ブランク
        trim(engine_disp, ' 　')::varchar(4) as engine_disp,  -- 右左ブランク
        trim(category, ' 　')::varchar(8) as category,  -- 右左ブランク
        trim(printno, ' 　')::varchar(2) as printno,  -- 右左ブランク
        trim(maxweight2, ' 　')::varchar(5) as maxweight2,  -- 右左ブランク
        trim(maxconbi2, ' 　')::varchar(5) as maxconbi2,  -- 右左ブランク
        trim(fr_axleload2, ' 　')::varchar(4) as fr_axleload2,  -- 右左ブランク
        trim(rr_axleload2, ' 　')::varchar(4) as rr_axleload2,  -- 右左ブランク
        trim(fr_tireprsr2, ' 　')::varchar(3) as fr_tireprsr2,  -- 右左ブランク
        trim(rr_tireprsr2, ' 　')::varchar(3) as rr_tireprsr2,  -- 右左ブランク
        trim(plate_kata, ' 　')::varchar(22) as plate_kata,  -- 右左ブランク
        trim(emitn_code, ' 　')::varchar(5) as emitn_code,  -- 右左ブランク
        trim(approval2, ' 　')::varchar(21) as approval2,  -- 右左ブランク
        trim(motor1_kata, ' 　')::varchar(11) as motor1_kata,  -- 右左ブランク
        trim(motor1_qty, ' 　')::varchar(3) as motor1_qty,  -- 右左ブランク
        trim(motor1_out, ' 　')::varchar(5) as motor1_out,  -- 右左ブランク
        trim(motor2_kata, ' 　')::varchar(11) as motor2_kata,  -- 右左ブランク
        trim(motor2_qty, ' 　')::varchar(3) as motor2_qty,  -- 右左ブランク
        trim(motor2_out, ' 　')::varchar(5) as motor2_out,  -- 右左ブランク
        trim(battery_voltage, ' 　')::varchar(6) as battery_voltage,  -- 右左ブランク
        trim(battery_capacity, ' 　')::varchar(5) as battery_capacity,  -- 右左ブランク
        trim(hydr_tank1_kata, ' 　')::varchar(2) as hydr_tank1_kata,  -- 右左ブランク
        trim(hydr_tank2_kata, ' 　')::varchar(2) as hydr_tank2_kata,  -- 右左ブランク
        trim(hydr_tank1_capa, ' 　')::varchar(5) as hydr_tank1_capa,  -- 右左ブランク
        trim(hydr_tank1_qty, ' 　')::varchar(3) as hydr_tank1_qty,  -- 右左ブランク
        trim(hydr_tank_press, ' 　')::varchar(3) as hydr_tank_press,  -- 右左ブランク
        trim(engine_rpm, ' 　')::varchar(4) as engine_rpm,  -- 右左ブランク
        trim(iwvta_approval, ' 　')::varchar(18) as iwvta_approval,  -- 右左ブランク
        trim(japanese_year_model, ' 　')::varchar(3) as japanese_year_model,  -- 右左ブランク
        trim(dum_cr, ' 　')::varchar(214) as dum_cr,  -- 右左ブランク
        trim(comment1, ' 　')::varchar(50) as comment1,  -- 右左ブランク
        trim(comment2, ' 　')::varchar(50) as comment2,  -- 右左ブランク
        trim(comment3, ' 　')::varchar(50) as comment3,  -- 右左ブランク
        trim(comment4, ' 　')::varchar(50) as comment4,  -- 右左ブランク
        to_timestamp_ntz(trim(his_create_date, ' 　'))::timestamp_ntz(6) as his_create_date,  -- 右左ブランク
        to_timestamp_ntz(trim(__created_at, ' 　'))::timestamp_ntz(6) as __created_at,  -- 右左ブランク
        to_timestamp_ntz(trim(__updated_at, ' 　'))::timestamp_ntz(6) as __updated_at,  -- 右左ブランク
        ldts,  -- B層のldts
        row_number() over (
            partition by
                sfkey
            order by
                ldts desc,
                line_number desc
        ) aggkey
    from {{ ref('extract_iotalcjfy1g4sf0')}}

    {% if is_incremental() %}
        where ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey)
from stg_jfy1_sfbase_history_iotpf_kojoiot_subaru
where aggkey = 1