{{ config(
      materialized='incremental',
      unique_key = ['yohinsyamei','tuikou', 'seg', 'seq'],
      incremental_strategy = 'merge'
   ) }}

with stg_genyohinmaster as (
    select
        syamei::varchar(3) as yohinsyamei, --なし
        rtrim(tuikou, ' 　')::varchar(8) as tuikou, -- 右blank
        rtrim(seg, ' 　')::varchar(3) as seg, -- 右blank
        rtrim(seq, ' 　')::varchar(3) as seq, -- 右blank
        data1_kubun ::varchar(1) as data1_kubun, --なし
        data1_renban ::varchar(7) as data1_renban, --なし
        data1_cdno ::varchar(1) as data1_cdno, --なし
        data1_kbn ::varchar(1) as data1_kbn, --なし
        data1_syamei ::varchar(3) as data1_syamei, --なし
        data1_tuikou ::varchar(4) as tk_cd, --なし
        data1_seg ::varchar(3) as data1_seg, --なし
        data1_seq ::varchar(3) as data1_seq, --なし
        data1_tuimei ::varchar(30) as tsuikou_name, --なし
        data1_katbit ::varchar(70) as data1_katbit, --なし
        data1_naigai ::varchar(1) as data1_naigai, --なし
        data1_tekiir1 ::varchar(4) as data1_tekiir1, --なし
        data1_tekiir2 ::varchar(4) as data1_tekiir2, --なし
        data1_tekiir3 ::varchar(4) as data1_tekiir3, --なし
        data1_tekiir4 ::varchar(4) as data1_tekiir4, --なし
        data1_tekiir5 ::varchar(4) as data1_tekiir5, --なし
        data1_tekiir6 ::varchar(4) as data1_tekiir6, --なし
        data1_tekiir7 ::varchar(4) as data1_tekiir7, --なし
        data1_tekiir8 ::varchar(4) as data1_tekiir8, --なし
        data1_tekiir9 ::varchar(4) as data1_tekiir9, --なし
        data1_tekiir10 ::varchar(4) as data1_tekiir10, --なし
        data1_hinban ::varchar(10) as data1_hinban, --なし
        data1_ruibet ::varchar(2) as data1_ruibet, --なし
        data1_hinmei ::varchar(51) as data1_hinmei, --なし
        data1_dum ::varchar(23) as data1_dum, --なし
        data2_kubun ::varchar(1) as data2_kubun, --なし
        data2_renban ::varchar(7) as data2_renban, --なし
        data2_cdno ::varchar(1) as data2_cdno, --なし
        data2_ruimei ::varchar(20) as data2_ruimei, --なし
        data2_tekikr ::varchar(6) as data2_tekikr,
        rtrim(data2_tekimd, ' 　')::varchar(6) as data2_tekimd, -- 右blank
        data2_sochak ::varchar(3) as data2_sochak, --なし
        data2_tekicm ::varchar(50) as data2_tekicm, --なし
        data2_kosuu ::varchar(2) as data2_kosuu, --なし
        data2_lp ::varchar(8) as data2_lp, --なし
        data2_dn ::varchar(8) as data2_dn, --なし
        data2_torihi ::varchar(8) as data2_torihi,
        data2_torijkn ::varchar(2) as data2_torijkn, --なし
        data2_syohin ::varchar(6) as data2_syohin, --なし
        data2_treecd ::varchar(7) as data2_treecd, --なし
        data2_syasin ::varchar(3) as data2_syasin, --なし
        data2_suisyo ::varchar(1) as data2_suisyo, --なし
        rtrim(data2_delflg, ' 　')::varchar(6) as data2_delflg, -- 右blank
        data2_tekiir11 ::varchar(4) as data2_tekiir11, --なし
        data2_tekiir12 ::varchar(4) as data2_tekiir12, --なし
        data2_tekiir13 ::varchar(4) as data2_tekiir13, --なし
        data2_tekiir14 ::varchar(4) as data2_tekiir14, --なし
        data2_tekiir15 ::varchar(4) as data2_tekiir15, --なし
        data2_tekiir16 ::varchar(4) as data2_tekiir16, --なし
        data2_tekiir17 ::varchar(4) as data2_tekiir17, --なし
        data2_tekiir18 ::varchar(4) as data2_tekiir18, --なし
        data2_tekiir19 ::varchar(4) as data2_tekiir19, --なし
        data2_tekiir20 ::varchar(4) as data2_tekiir20, --なし
        data2_tekiir21 ::varchar(4) as data2_tekiir21, --なし
        data2_tekiir22 ::varchar(4) as data2_tekiir22, --なし
        data2_tekiir23 ::varchar(4) as data2_tekiir23, --なし
        data2_tekiir24 ::varchar(4) as data2_tekiir24, --なし
        data2_tekiir25 ::varchar(4) as data2_tekiir25, --なし
        data2_tekiir26 ::varchar(4) as data2_tekiir26, --なし
        data2_tekiir27 ::varchar(4) as data2_tekiir27, --なし
        data2_tekiir28 ::varchar(4) as data2_tekiir28, --なし
        data2_tekiir29 ::varchar(4) as data2_tekiir29, --なし
        data2_tekiir30 ::varchar(4) as data2_tekiir30, --なし
        data2_dum ::varchar(30) as data2_dum, --なし
        try_to_timestamp_ntz(touroku,'yyyymmdd') as touroku, --timestamp
        try_to_timestamp_ntz(kousin,'yyyymmdd') as kousin, --timestamp
        tantou ::varchar(7) as tantou, --なし
        ldts, -- B層のldts
        row_number() over(partition by yohinsyamei, tuikou order by data2_tekikr desc, seg desc, seq desc, ldts desc) aggkey
    from {{ ref('substr_tpjfva41') }}
           
  {% if is_incremental() %}
      where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_genyohinmaster
where aggkey = 1