with stg_shkjissekiruikei as (
    select
        rtrim(syotype, ' 　')::varchar(1) as syotype, -- 英数字
        rtrim(lpcl, ' 　')::varchar(1) as lpcl, -- 英数字
        rtrim(shp_pno, ' 　')::varchar(20) as shp_pno, -- 英数字
        to_decimal(iff(rtrim(pik_qt) = '', 0, rtrim(pik_qt)))::decimal(7) as pik_qt, -- 数量／金額／数値
        rtrim(dstcd, ' 　')::varchar(7) as dstcd, -- 英数字
        rtrim(dst_zn, ' 　')::varchar(3) as dst_zn, -- 英数字
        rtrim(odno, ' 　')::varchar(8) as odno, -- 英数字
        rtrim(itmno, ' 　')::varchar(4) as itmno, -- 英数字
        rtrim(remrk, ' 　')::varchar(10) as remrk, -- 英数字
        rtrim(odcl, ' 　')::varchar(4) as odcl, -- 英数字
        rtrim(trncl, ' 　')::varchar(1) as trncl, -- 英数字
        rtrim(pak_formcd, ' 　')::varchar(2) as pak_formcd, -- 英数字
        rtrim(tkod_dt, ' 　')::varchar(8) as tkod_dt, -- 英数字
        rtrim(shpdr_dt, ' 　')::varchar(8) as shpdr_dt, -- 英数字
        rtrim(wk_lt_frdt, ' 　')::varchar(8) as wk_lt_frdt, -- 英数字
        rtrim(od_key, ' 　')::varchar(11) as od_key, -- 英数字
        rtrim(og, ' 　')::varchar(2) as og, -- 英数字
        rtrim(spakno, ' 　')::varchar(4) as spakno, -- 英数字
        rtrim(cyc_sno, ' 　')::varchar(11) as cyc_sno, -- 英数字
        rtrim(ab_key, ' 　')::varchar(11) as ab_key, -- 英数字
        rtrim(brno1, ' 　')::varchar(2) as brno1, -- 英数字
        rtrim(brno2, ' 　')::varchar(2) as brno2, -- 英数字
        rtrim(ab_keybrno1brno2, ' 　')::varchar(15) as ab_keybrno1brno2, -- 英数字
        rtrim(sam_dstcd, ' 　')::varchar(7) as sam_dstcd, -- 英数字
        rtrim(pstcl, ' 　')::varchar(1) as pstcl, -- 英数字
        rtrim(pstcd, ' 　')::varchar(2) as pstcd, -- 英数字
        rtrim(pikdr_loc, ' 　')::varchar(3) as pikdr_loc, -- 英数字
        rtrim(zncd, ' 　')::varchar(3) as zncd, -- 英数字
        rtrim(loc, ' 　')::varchar(10) as loc, -- 英数字
        rtrim(high_drcl, ' 　')::varchar(1) as high_drcl, -- 英数字
        rtrim(dsptno, ' 　')::varchar(2) as dsptno, -- 英数字
        rtrim(caryo_dstcd, ' 　')::varchar(3) as caryo_dstcd, -- 英数字
        rtrim(dlv_plncl, ' 　')::varchar(1) as dlv_plncl, -- 英数字
        rtrim(pln_odfl, ' 　')::varchar(1) as pln_odfl, -- 英数字
        rtrim(pln_og, ' 　')::varchar(2) as pln_og, -- 英数字
        rtrim(lccl, ' 　')::varchar(1) as lccl, -- 英数字
        rtrim(ptpflg, ' 　')::varchar(1) as ptpflg, -- 英数字
        rtrim(unno, ' 　')::varchar(4) as unno, -- 英数字
        rtrim(nbrk_salcl, ' 　')::varchar(1) as nbrk_salcl, -- 英数字
        rtrim(uni_ivc, ' 　')::varchar(1) as uni_ivc, -- 英数字
        rtrim(oth_mrkcd, ' 　')::varchar(4) as oth_mrkcd, -- 英数字
        rtrim(stpflg, ' 　')::varchar(1) as stpflg, -- 英数字
        rtrim(ps_impflg, ' 　')::varchar(1) as ps_impflg, -- 英数字
        rtrim(itns_vanflg, ' 　')::varchar(1) as itns_vanflg, -- 英数字
        rtrim(uni_vanflg, ' 　')::varchar(1) as uni_vanflg, -- 英数字
        rtrim(oth_pacflg, ' 　')::varchar(1) as oth_pacflg, -- 英数字
        rtrim(tarifcd, ' 　')::varchar(3) as tarifcd, -- 英数字
        rtrim(dngflg, ' 　')::varchar(1) as dngflg, -- 英数字
        rtrim(dng_cls, ' 　')::varchar(3) as dng_cls, -- 英数字
        to_decimal(iff(rtrim(lit_std) = '', 0, rtrim(lit_std)))::decimal(4) as lit_std, -- 数量／金額／数値
        rtrim(gudcl, ' 　')::varchar(1) as gudcl, -- 英数字
        rtrim(spc_natcl, ' 　')::varchar(1) as spc_natcl, -- 英数字
        to_decimal(iff(rtrim(pno_szl) = '', 0, rtrim(pno_szl)))::decimal(5) as pno_szl, -- 数量／金額／数値
        to_decimal(iff(rtrim(pno_szw) = '', 0, rtrim(pno_szw)))::decimal(5) as pno_szw, -- 数量／金額／数値
        to_decimal(iff(rtrim(pno_szh) = '', 0, rtrim(pno_szh)))::decimal(5) as pno_szh, -- 数量／金額／数値
        to_decimal(iff(rtrim(cap) = '', 0, rtrim(cap)))::decimal(11) as cap, -- 数量／金額／数値
        to_decimal(iff(rtrim(rl_vol) = '', 0, rtrim(rl_vol)))::decimal(9) as rl_vol, -- 数量／金額／数値
        to_decimal(iff(rtrim(adj_vol) = '', 0, rtrim(adj_vol)))::decimal(6) as adj_vol, -- 数量／金額／数値
        to_decimal(iff(rtrim(bskt_qtpc) = '', 0, rtrim(bskt_qtpc)))::decimal(8) as bskt_qtpc, -- 数量／金額／数値
        rtrim(bskt, ' 　')::varchar(2) as bskt, -- 英数字
        to_decimal(iff(rtrim(qtpc) = '', 0, rtrim(qtpc)))::decimal(6) as qtpc, -- 数量／金額／数値
        rtrim(dlv_lpcl, ' 　')::varchar(1) as dlv_lpcl, -- 英数字
        rtrim(splcd, ' 　')::varchar(4) as splcd, -- 英数字
        rtrim(plntcd, ' 　')::varchar(1) as plntcd, -- 英数字
        rtrim(rouh_pno, ' 　')::varchar(20) as rouh_pno, -- 英数字
        rtrim(prod_rebldcl, ' 　')::varchar(1) as prod_rebldcl, -- 英数字
        rtrim(addwkcl, ' 　')::varchar(1) as addwkcl, -- 英数字
        rtrim(nstk_ptncl, ' 　')::varchar(1) as nstk_ptncl, -- 英数字
        rtrim(nstk_pik_ptncl, ' 　')::varchar(1) as nstk_pik_ptncl, -- 英数字
        rtrim(shp_box_dvcl, ' 　')::varchar(1) as shp_box_dvcl, -- 英数字
        rtrim(slwcl, ' 　')::varchar(1) as slwcl, -- 英数字
        rtrim(batcl, ' 　')::varchar(1) as batcl, -- 英数字
        rtrim(pik_frtm, ' 　')::varchar(14) as pik_frtm, -- 英数字
        rtrim(pik_dv_frtm, ' 　')::varchar(14) as pik_dv_frtm, -- 英数字
        rtrim(pik_totm, ' 　')::varchar(14) as pik_totm, -- 英数字
        rtrim(st_stk_refcl, ' 　')::varchar(1) as st_stk_refcl, -- 英数字
        rtrim(pak_ob_othcl, ' 　')::varchar(2) as pak_ob_othcl, -- 英数字
        rtrim(btlpp_loccd, ' 　')::varchar(3) as btlpp_loccd, -- 英数字
        to_decimal(iff(rtrim(pik_nestm) = '', 0, rtrim(pik_nestm)))::decimal(4) as pik_nestm, -- 数量／金額／数値
        rtrim(shpno, ' 　')::varchar(5) as shpno, -- 英数字
        rtrim(dlno, ' 　')::varchar(8) as dlno, -- 英数字
        rtrim(lgno1, ' 　')::varchar(10) as lgno1, -- 英数字
        rtrim(lgno2, ' 　')::varchar(10) as lgno2, -- 英数字
        rtrim(lgno3, ' 　')::varchar(10) as lgno3, -- 英数字
        rtrim(httdlno, ' 　')::varchar(8) as httdlno, -- 英数字
        rtrim(httlgno1, ' 　')::varchar(10) as httlgno1, -- 英数字
        rtrim(httlgno2, ' 　')::varchar(10) as httlgno2, -- 英数字
        rtrim(httlgno3, ' 　')::varchar(10) as httlgno3, -- 英数字
        rtrim(znstr_itns_gno, ' 　')::varchar(3) as znstr_itns_gno, -- 英数字
        to_decimal(iff(rtrim(znstr_prty) = '', 0, rtrim(znstr_prty)))::decimal(3) as znstr_prty, -- 数量／金額／数値
        rtrim(hdlb_pbflg, ' 　')::varchar(1) as hdlb_pbflg, -- 英数字
        rtrim(pak_cascd, ' 　')::varchar(2) as pak_cascd, -- 英数字
        rtrim(pik_cascd, ' 　')::varchar(4) as pik_cascd, -- 英数字
        rtrim(mny_od_ahcl, ' 　')::varchar(1) as mny_od_ahcl, -- 英数字
        rtrim(flc_carovcl, ' 　')::varchar(1) as flc_carovcl, -- 英数字
        rtrim(flcrcl, ' 　')::varchar(1) as flcrcl, -- 英数字
        rtrim(pik_todt, ' 　')::varchar(14) as pik_todt, -- 英数字
        rtrim(pikdr_dttm, ' 　')::varchar(14) as pikdr_dttm, -- 英数字
        rtrim(pikdr_chrcd, ' 　')::varchar(5) as pikdr_chrcd, -- 英数字
        rtrim(dom_fogcl, ' 　')::varchar(1) as dom_fogcl, -- 英数字
        rtrim(rsv_chrcd, ' 　')::varchar(5) as rsv_chrcd, -- 英数字
        rtrim(tpik_dttm, ' 　')::varchar(14) as tpik_dttm, -- 英数字
        rtrim(tpik_chrcd, ' 　')::varchar(5) as tpik_chrcd, -- 英数字
        rtrim(tput_dttm, ' 　')::varchar(14) as tput_dttm, -- 英数字
        rtrim(tput_chrcd, ' 　')::varchar(5) as tput_chrcd, -- 英数字
        rtrim(tputflg, ' 　')::varchar(1) as tputflg, -- 英数字
        rtrim(pik_cp_dttm, ' 　')::varchar(14) as pik_cp_dttm, -- 英数字
        rtrim(pik_cp_chrcd, ' 　')::varchar(5) as pik_cp_chrcd, -- 英数字
        rtrim(pik_cpno, ' 　')::varchar(13) as pik_cpno, -- 英数字
        rtrim(res_scopno, ' 　')::varchar(2) as res_scopno, -- 英数字
        rtrim(res_storeno, ' 　')::varchar(4) as res_storeno, -- 英数字
        rtrim(gathcl, ' 　')::varchar(1) as gathcl, -- 英数字
        rtrim(pcpcl, ' 　')::varchar(1) as pcpcl, -- 英数字
        rtrim(pik_lpcl, ' 　')::varchar(1) as pik_lpcl, -- 英数字
        rtrim(collcl, ' 　')::varchar(1) as collcl, -- 英数字
        rtrim(paltzcl, ' 　')::varchar(1) as paltzcl, -- 英数字
        rtrim(pik_detlb_pbflg, ' 　')::varchar(1) as pik_detlb_pbflg, -- 英数字
        rtrim(fail_aup_dttm, ' 　')::varchar(14) as fail_aup_dttm, -- 英数字
        rtrim(fail_aup_chrcd, ' 　')::varchar(5) as fail_aup_chrcd, -- 英数字
        to_decimal(iff(rtrim(fail_qt) = '', 0, rtrim(fail_qt)))::decimal(7) as fail_qt, -- 数量／金額／数値
        rtrim(rpl_aup_dttm, ' 　')::varchar(14) as rpl_aup_dttm, -- 英数字
        rtrim(rpl_aup_chrcd, ' 　')::varchar(5) as rpl_aup_chrcd, -- 英数字
        to_decimal(iff(rtrim(rpl_qt) = '', 0, rtrim(rpl_qt)))::decimal(7) as rpl_qt, -- 数量／金額／数値
        rtrim(chk_aup_dttm, ' 　')::varchar(14) as chk_aup_dttm, -- 英数字
        rtrim(chk_aup_chrcd, ' 　')::varchar(5) as chk_aup_chrcd, -- 英数字
        to_decimal(iff(rtrim(chk_qt) = '', 0, rtrim(chk_qt)))::decimal(7) as chk_qt, -- 数量／金額／数値
        rtrim(tcas_pak_dttm, ' 　')::varchar(14) as tcas_pak_dttm, -- 英数字
        rtrim(tcas_pak_chrcd, ' 　')::varchar(5) as tcas_pak_chrcd, -- 英数字
        rtrim(tcasno, ' 　')::varchar(12) as tcasno, -- 英数字
        rtrim(pak_dttm, ' 　')::varchar(14) as pak_dttm, -- 英数字
        rtrim(casno, ' 　')::varchar(8) as casno, -- 英数字
        rtrim(caslb_pb_prtno, ' 　')::varchar(1) as caslb_pb_prtno, -- 英数字
        rtrim(pak_chrcd, ' 　')::varchar(5) as pak_chrcd, -- 英数字
        rtrim(pak_lpcl, ' 　')::varchar(1) as pak_lpcl, -- 英数字
        rtrim(mes_termno, ' 　')::varchar(6) as mes_termno, -- 英数字
        rtrim(nfixflg, ' 　')::varchar(1) as nfixflg, -- 英数字
        rtrim(pak_fwflg, ' 　')::varchar(1) as pak_fwflg, -- 英数字
        rtrim(shp_stat, ' 　')::varchar(2) as shp_stat, -- 英数字
        rtrim(shp_dttm, ' 　')::varchar(14) as shp_dttm, -- 英数字
        rtrim(shp_chrcd, ' 　')::varchar(5) as shp_chrcd, -- 英数字
        rtrim(htt_shp_dttm, ' 　')::varchar(14) as htt_shp_dttm, -- 英数字
        rtrim(htt_shp_chrcd, ' 　')::varchar(5) as htt_shp_chrcd, -- 英数字
        rtrim(shpinf_pik_fwflg, ' 　')::varchar(1) as shpinf_pik_fwflg, -- 英数字
        rtrim(odcan_dttm, ' 　')::varchar(14) as odcan_dttm, -- 英数字
        rtrim(odcan_chrcd, ' 　')::varchar(5) as odcan_chrcd, -- 英数字
        rtrim(canflg, ' 　')::varchar(1) as canflg, -- 英数字
        rtrim(chk_frtm, ' 　')::varchar(14) as chk_frtm, -- 英数字
        rtrim(chk_totm, ' 　')::varchar(14) as chk_totm, -- 英数字
        rtrim(hand_iputcl, ' 　')::varchar(1) as hand_iputcl, -- 英数字
        rtrim(bar_hist01, ' 　')::varchar(1) as bar_hist01, -- 英数字
        rtrim(bar_hist02, ' 　')::varchar(1) as bar_hist02, -- 英数字
        rtrim(bar_hist03, ' 　')::varchar(1) as bar_hist03, -- 英数字
        rtrim(bar_hist04, ' 　')::varchar(1) as bar_hist04, -- 英数字
        rtrim(bar_hist05, ' 　')::varchar(1) as bar_hist05, -- 英数字
        rtrim(bar_hist06, ' 　')::varchar(1) as bar_hist06, -- 英数字
        rtrim(bar_hist07, ' 　')::varchar(1) as bar_hist07, -- 英数字
        rtrim(bar_hist08, ' 　')::varchar(1) as bar_hist08, -- 英数字
        rtrim(bar_hist09, ' 　')::varchar(1) as bar_hist09, -- 英数字
        rtrim(bar_hist10, ' 　')::varchar(1) as bar_hist10, -- 英数字
        rtrim(njit_shpaup_dttm, ' 　')::varchar(14) as njit_shpaup_dttm, -- 英数字
        rtrim(njit_ctlno, ' 　')::varchar(3) as njit_ctlno, -- 英数字
        rtrim(njit_logino, ' 　')::varchar(10) as njit_logino, -- 英数字
        rtrim(njit_trntrcd, ' 　')::varchar(4) as njit_trntrcd, -- 英数字
        to_decimal(iff(rtrim(njit_cas_cap) = '', 0, rtrim(njit_cas_cap)))::decimal(7) as njit_cas_cap, -- 数量／金額／数値
        to_decimal(iff(rtrim(njit_cas_vol) = '', 0, rtrim(njit_cas_vol)))::decimal(5) as njit_cas_vol, -- 数量／金額／数値
        rtrim(httcl, ' 　')::varchar(1) as httcl, -- 英数字
        rtrim(njit_failaup_dttm, ' 　')::varchar(14) as njit_failaup_dttm, -- 英数字
        rtrim(njit_odcan_dttm, ' 　')::varchar(14) as njit_odcan_dttm, -- 英数字
        rtrim(chr_ofc, ' 　')::varchar(5) as chr_ofc, -- 英数字
        rtrim(chrcd, ' 　')::varchar(2) as chrcd, -- 英数字
        rtrim(prccl, ' 　')::varchar(1) as prccl, -- 英数字
        rtrim(cur_chngdtcl, ' 　')::varchar(1) as cur_chngdtcl, -- 英数字
        rtrim(nw_chngdtcl, ' 　')::varchar(1) as nw_chngdtcl, -- 英数字
        rtrim(stk_refcl, ' 　')::varchar(1) as stk_refcl, -- 英数字
        rtrim(nw_stk_refcl, ' 　')::varchar(1) as nw_stk_refcl, -- 英数字
        rtrim(cur_arr_form, ' 　')::varchar(1) as cur_arr_form, -- 英数字
        rtrim(nw_arr_form, ' 　')::varchar(1) as nw_arr_form, -- 英数字
        rtrim(fw_tcasno, ' 　')::varchar(12) as fw_tcasno, -- 英数字
        rtrim(fw_tcas_pak_chrcd, ' 　')::varchar(5) as fw_tcas_pak_chrcd, -- 英数字
        rtrim(fw_tcas_pak_dttm, ' 　')::varchar(14) as fw_tcas_pak_dttm, -- 英数字
        rtrim(fwdr_chrcd, ' 　')::varchar(5) as fwdr_chrcd, -- 英数字
        rtrim(fwdr_dttm, ' 　')::varchar(14) as fwdr_dttm, -- 英数字
        rtrim(kanbancl, ' 　')::varchar(1) as kanbancl, -- 英数字
        rtrim(kanban_sno, ' 　')::varchar(100) as kanban_sno, -- 英数字
        rtrim(pln_prc_num, ' 　')::varchar(2) as pln_prc_num, -- 英数字
        rtrim(pik_caryo_aup_dttm, ' 　')::varchar(14) as pik_caryo_aup_dttm, -- 英数字
        rtrim(pik_caryo_chrcd, ' 　')::varchar(5) as pik_caryo_chrcd, -- 英数字
        rtrim(pik_dlno, ' 　')::varchar(8) as pik_dlno, -- 英数字
        rtrim(pik_caryi_aup_dttm, ' 　')::varchar(14) as pik_caryi_aup_dttm, -- 英数字
        rtrim(pik_caryi_chrcd, ' 　')::varchar(5) as pik_caryi_chrcd, -- 英数字
        rtrim(tcas_caryo_aup_dttm, ' 　')::varchar(14) as tcas_caryo_aup_dttm, -- 英数字
        rtrim(tcas_caryo_chrcd, ' 　')::varchar(5) as tcas_caryo_chrcd, -- 英数字
        rtrim(tcas_dlno, ' 　')::varchar(8) as tcas_dlno, -- 英数字
        rtrim(tcas_caryi_aup_dttm, ' 　')::varchar(14) as tcas_caryi_aup_dttm, -- 英数字
        rtrim(tcas_caryi_chrcd, ' 　')::varchar(5) as tcas_caryi_chrcd, -- 英数字
        rtrim(tset_dttm, ' 　')::varchar(14) as tset_dttm, -- 英数字
        rtrim(tset_chrcd, ' 　')::varchar(5) as tset_chrcd, -- 英数字
        rtrim(pak_dno, ' 　')::varchar(2) as pak_dno, -- 英数字
        rtrim(pln_pikdr_dt, ' 　')::varchar(8) as pln_pikdr_dt, -- 英数字
        rtrim(pik_fw_dttm, ' 　')::varchar(14) as pik_fw_dttm, -- 英数字
        rtrim(ivcdr_dttm, ' 　')::varchar(14) as ivcdr_dttm, -- 英数字
        rtrim(bo_repikcl, ' 　')::varchar(1) as bo_repikcl, -- 英数字
        rtrim(ofqtcl, ' 　')::varchar(1) as ofqtcl, -- 英数字
        rtrim(caryi_aup_dttm, ' 　')::varchar(14) as caryi_aup_dttm, -- 英数字
        rtrim(caryo_aup_dttm, ' 　')::varchar(14) as caryo_aup_dttm, -- 英数字
        rtrim(inv_prc_dttm, ' 　')::varchar(14) as inv_prc_dttm, -- 英数字
        rtrim(rbscd, ' 　')::varchar(3) as rbscd, -- 英数字
        rtrim(tot_cap, ' 　')::varchar(10) as tot_cap, -- 英数字
        rtrim(szl, ' 　')::varchar(5) as szl, -- 英数字
        rtrim(szw, ' 　')::varchar(5) as szw, -- 英数字
        rtrim(szh, ' 　')::varchar(5) as szh, -- 英数字
        ldts, -- B層のLDTS
        rank() over (partition by lpcl, cyc_sno, tkod_dt order by ldts desc) aggkey
    from {{ ref('substr_shkjissekiruikei') }}
)
select * from stg_shkjissekiruikei
where aggkey = 1
