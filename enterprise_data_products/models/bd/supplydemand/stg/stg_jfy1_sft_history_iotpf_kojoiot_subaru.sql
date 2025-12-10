{{
    config (
        materialized = 'incremental',
        unique_key = ['sfkey'],
        incremental_strategy = 'merge'
    )
}}

with stg_jfy1_sft_history_iotpf_kojoiot_subaru as (
    select
        trim(sfkey, ' 　')::varchar(16) as sfkey,  -- 右左ブランク
        trim(latesttp_line, ' 　')::varchar(1) as latesttp_line,  -- 右左ブランク
        trim(latesttp_tp, ' 　')::varchar(2) as latesttp_tp,  -- 右左ブランク
        trim(latesttp_bcseq, ' 　')::varchar(3) as latesttp_bcseq,  -- 右左ブランク
        trim(latesttp_count, ' 　')::varchar(1) as latesttp_count,  -- 右左ブランク
        trim(latesttp_pdate, ' 　')::varchar(15) as latesttp_pdate,  -- 右左ブランク
        trim(latesttp_cdate, ' 　')::varchar(14) as latesttp_cdate,  -- 右左ブランク
        trim(curproc_line, ' 　')::varchar(1) as curproc_line,  -- 右左ブランク
        trim(curproc_proc, ' 　')::varchar(2) as curproc_proc,  -- 右左ブランク
        trim(dum_ps, ' 　')::varchar(11) as dum_ps,  -- 右左ブランク
        trim(latestrp_line, ' 　')::varchar(1) as latestrp_line,  -- 右左ブランク
        trim(latestrp_rp, ' 　')::varchar(2) as latestrp_rp,  -- 右左ブランク
        trim(latestrp_bcseq, ' 　')::varchar(3) as latestrp_bcseq,  -- 右左ブランク
        trim(latestrp_count, ' 　')::varchar(1) as latestrp_count,  -- 右左ブランク
        trim(latestrp_pdate, ' 　')::varchar(15) as latestrp_pdate,  -- 右左ブランク
        trim(latestrp_cdate, ' 　')::varchar(14) as latestrp_cdate,  -- 右左ブランク
        trim(rprproc_line, ' 　')::varchar(1) as rprproc_line,  -- 右左ブランク
        trim(rprproc_proc, ' 　')::varchar(2) as rprproc_proc,  -- 右左ブランク
        trim(online_flg, ' 　')::varchar(1) as online_flg,  -- 右左ブランク
        trim(reftp_line, ' 　')::varchar(1) as reftp_line,  -- 右左ブランク
        trim(reftp_tp, ' 　')::varchar(2) as reftp_tp,  -- 右左ブランク
        trim(dum_rs, ' 　')::varchar(7) as dum_rs,  -- 右左ブランク
        trim(latestpt_line, ' 　')::varchar(1) as latestpt_line,  -- 右左ブランク
        trim(latestpt_pt, ' 　')::varchar(2) as latestpt_pt,  -- 右左ブランク
        trim(latestpt_bcseq, ' 　')::varchar(3) as latestpt_bcseq,  -- 右左ブランク
        trim(latestpt_count, ' 　')::varchar(1) as latestpt_count,  -- 右左ブランク
        trim(latestpt_pdate, ' 　')::varchar(15) as latestpt_pdate,  -- 右左ブランク
        trim(latestpt_cdate, ' 　')::varchar(14) as latestpt_cdate,  -- 右左ブランク
        trim(physproc_line, ' 　')::varchar(1) as physproc_line,  -- 右左ブランク
        trim(physproc_proc, ' 　')::varchar(2) as physproc_proc,  -- 右左ブランク
        trim(cdlytime, ' 　')::varchar(7) as cdlytime,  -- 右左ブランク
        trim(prgrs_sgn, ' 　')::varchar(1) as prgrs_sgn,  -- 右左ブランク
        trim(spr_tp, ' 　')::varchar(7) as spr_tp,  -- 右左ブランク
        trim(spr_bo, ' 　')::varchar(7) as spr_bo,  -- 右左ブランク
        trim(spr_deli, ' 　')::varchar(7) as spr_deli,  -- 右左ブランク
        trim(ltresult, ' 　')::varchar(7) as ltresult,  -- 右左ブランク
        trim(ltresult_bs, ' 　')::varchar(7) as ltresult_bs,  -- 右左ブランク
        trim(rjt_flg, ' 　')::varchar(1) as rjt_flg,  -- 右左ブランク
        trim(dum_ts, ' 　')::varchar(317) as dum_ts,  -- 右左ブランク
        trim(frmstamp, ' 　')::varchar(17) as frmstamp,  -- 右左ブランク
        trim(vinno, ' 　')::varchar(17) as vinno,  -- 右左ブランク
        trim(vincd, ' 　')::varchar(1) as vincd,  -- 右左ブランク
        trim(apv_pr_no, ' 　')::varchar(12) as apv_pr_no,  -- 右左ブランク
        trim(dum_an, ' 　')::varchar(53) as dum_an,  -- 右左ブランク
        trim(inspect_sign, ' 　')::varchar(1) as inspect_sign,  -- 右左ブランク
        trim(accident, ' 　')::varchar(1) as accident,  -- 右左ブランク
        trim(hold_line, ' 　')::varchar(1) as hold_line,  -- 右左ブランク
        trim(hold_tp, ' 　')::varchar(2) as hold_tp,  -- 右左ブランク
        trim(hold_code1, ' 　')::varchar(2) as hold_code1,  -- 右左ブランク
        trim(hold_code2, ' 　')::varchar(2) as hold_code2,  -- 右左ブランク
        trim(hold_code3, ' 　')::varchar(2) as hold_code3,  -- 右左ブランク
        trim(hold_ptime, ' 　')::varchar(13) as hold_ptime,  -- 右左ブランク
        trim(delbase_date, ' 　')::varchar(8) as delbase_date,  -- 右左ブランク
        trim(erase_time, ' 　')::varchar(14) as erase_time,  -- 右左ブランク
        trim(exc_time, ' 　')::varchar(14) as exc_time,  -- 右左ブランク
        trim(amend_time, ' 　')::varchar(14) as amend_time,  -- 右左ブランク
        trim(amend_dfsc_time, ' 　')::varchar(14) as amend_dfsc_time,  -- 右左ブランク
        trim(amend_entry_time, ' 　')::varchar(14) as amend_entry_time,  -- 右左ブランク
        trim(cancel_time, ' 　')::varchar(14) as cancel_time,  -- 右左ブランク
        trim(jt5_month, ' 　')::varchar(6) as jt5_month,  -- 右左ブランク
        trim(sts_change_time, ' 　')::varchar(14) as sts_change_time,  -- 右左ブランク
        trim(inpt_trm, ' 　')::varchar(1) as inpt_trm,  -- 右左ブランク
        trim(egchange_flg, ' 　')::varchar(1) as egchange_flg,  -- 右左ブランク
        trim(newmodel_flg, ' 　')::varchar(1) as newmodel_flg,  -- 右左ブランク
        trim(spvehicle_flg, ' 　')::varchar(1) as spvehicle_flg,  -- 右左ブランク
        trim(audit_code01, ' 　')::varchar(3) as audit_code01,  -- 右左ブランク
        trim(audit_code02, ' 　')::varchar(3) as audit_code02,  -- 右左ブランク
        trim(audit_code03, ' 　')::varchar(3) as audit_code03,  -- 右左ブランク
        trim(audit_code04, ' 　')::varchar(3) as audit_code04,  -- 右左ブランク
        trim(audit_code05, ' 　')::varchar(3) as audit_code05,  -- 右左ブランク
        trim(audit_code06, ' 　')::varchar(3) as audit_code06,  -- 右左ブランク
        trim(audit_code07, ' 　')::varchar(3) as audit_code07,  -- 右左ブランク
        trim(audit_code08, ' 　')::varchar(3) as audit_code08,  -- 右左ブランク
        trim(audit_code09, ' 　')::varchar(3) as audit_code09,  -- 右左ブランク
        trim(audit_code10, ' 　')::varchar(3) as audit_code10,  -- 右左ブランク
        trim(combno, ' 　')::varchar(3) as combno,  -- 右左ブランク
        trim(combno_sub, ' 　')::varchar(20) as combno_sub,  -- 右左ブランク
        trim(dockstat, ' 　')::varchar(1) as dockstat,  -- 右左ブランク
        trim(paint_inst_pass, ' 　')::varchar(1) as paint_inst_pass,  -- 右左ブランク
        trim(paint_booth_code, ' 　')::varchar(1) as paint_booth_code,  -- 右左ブランク
        trim(weld_sampling_inspec1, ' 　')::varchar(2) as weld_sampling_inspec1,  -- 右左ブランク
        trim(weld_sampling_inspec2, ' 　')::varchar(2) as weld_sampling_inspec2,  -- 右左ブランク
        trim(weld_sampling_inspec3, ' 　')::varchar(2) as weld_sampling_inspec3,  -- 右左ブランク
        trim(carrier_reg_line, ' 　')::varchar(1) as carrier_reg_line,  -- 右左ブランク
        trim(carrier_reg_point, ' 　')::varchar(2) as carrier_reg_point,  -- 右左ブランク
        trim(carrier_reg_ep, ' 　')::varchar(4) as carrier_reg_ep,  -- 右左ブランク
        trim(carrier_reg_date, ' 　')::varchar(14) as carrier_reg_date,  -- 右左ブランク
        trim(dum_os, ' 　')::varchar(27) as dum_os,  -- 右左ブランク
        trim(dum_tsec, ' 　')::varchar(140) as dum_tsec,  -- 右左ブランク
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
    from {{ ref('extract_iotalcjfy1g4sft') }}

    {% if is_incremental() %}
        where ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey)
from stg_jfy1_sft_history_iotpf_kojoiot_subaru
where aggkey = 1