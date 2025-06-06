{{
    config (
        materialized = 'incremental',
        unique_key = ['ym', 'caltimingkbn', 'shamei', 'sno', 'yosokbn','yosoren'],
        incremental_strategy = 'merge',
        post_hook ="
              delete from {{this}} where try_to_timestamp_ntz(ym,'yyyymm') < dateadd(month, -36, (select try_to_timestamp_ntz(max(ym),'yyyymm') from {{this}}))
        "
    )
}}
--直近3年のみ保持する為post_hookによる削除処理を実装
with stg_haishayoubo_jpass as (
    select
        rtrim(ym,' 　')::varchar(6) as ym,  -- 右blank
        rtrim(caltimingkbn,' 　')::varchar(2) as caltimingkbn,  -- 右blank
        rtrim(bukbn,' 　')::varchar(1) as bukbn,  -- 右blank
        rtrim(shamei,' 　')::varchar(2) as shamei,  -- 右blank
        rtrim(sno,' 　')::varchar(2) as sno,  -- 右blank
        rtrim(yosokbn,' 　')::varchar(1) as yosokbn,  -- 右blank
        rtrim(yosoren,' 　')::varchar(5) as yosoren,  -- 右blank
        hckata::varchar(20) as hckata, 
        gaicd::varchar(4) as gaicd, 
        rtrim(ucd,' 　')::varchar(4) as ucd,  -- 右blank
        rtrim(tire,' 　')::varchar(3) as tire,  -- 右blank
        hoption::varchar(80) as hoption, 
        rtrim(haisyaybdain,' 　')::varchar(5) as haisyaybdain,  -- 右blank
        rtrim(haisyaybdain1,' 　')::varchar(5) as haisyaybdain1,  -- 右blank
        rtrim(haisyaybdain2,' 　')::varchar(5) as haisyaybdain2,  -- 右blank
        rtrim(haisyaybdain3,' 　')::varchar(5) as haisyaybdain3,  -- 右blank
        rtrim(haisyaybdain4,' 　')::varchar(5) as haisyaybdain4,  -- 右blank
        rtrim(haisyaybdain5,' 　')::varchar(5) as haisyaybdain5,  -- 右blank
        rtrim(haisyaybdain6,' 　')::varchar(5) as haisyaybdain6,  -- 右blank
        rtrim(haisyaybdain7,' 　')::varchar(5) as haisyaybdain7,  -- 右blank
        rtrim(haisyaybdain8,' 　')::varchar(5) as haisyaybdain8,  -- 右blank
        rtrim(haisyaybdain9,' 　')::varchar(5) as haisyaybdain9,  -- 右blank
        rtrim(haisyaybdain10,' 　')::varchar(5) as haisyaybdain10,  -- 右blank
        rtrim(haisyaybdain11,' 　')::varchar(5) as haisyaybdain11,  -- 右blank
        rtrim(haisyaybdain12,' 　')::varchar(5) as haisyaybdain12,  -- 右blank
        rtrim(haisyaybdain13,' 　')::varchar(5) as haisyaybdain13,  -- 右blank
        rtrim(haisyaybdain14,' 　')::varchar(5) as haisyaybdain14,  -- 右blank
        rtrim(haisyaybdain15,' 　')::varchar(5) as haisyaybdain15,  -- 右blank
        rtrim(haisyaybdain16,' 　')::varchar(5) as haisyaybdain16,  -- 右blank
        rtrim(haisyaybdain17,' 　')::varchar(5) as haisyaybdain17,  -- 右blank
        rtrim(haisyaybdain18,' 　')::varchar(5) as haisyaybdain18,  -- 右blank
        rtrim(haisyaybdain19,' 　')::varchar(5) as haisyaybdain19,  -- 右blank
        rtrim(haisyaybdain20,' 　')::varchar(5) as haisyaybdain20,  -- 右blank
        rtrim(haisyaybdain21,' 　')::varchar(5) as haisyaybdain21,  -- 右blank
        rtrim(haisyaybdain22,' 　')::varchar(5) as haisyaybdain22,  -- 右blank
        rtrim(haisyaybdain23,' 　')::varchar(5) as haisyaybdain23,  -- 右blank
        rtrim(jdumflg,' 　')::varchar(1) as jdumflg,  -- 右blank
        rtrim(haiyouflg,' 　')::varchar(1) as haiyouflg,  -- 右blank
        rtrim(serrmflg,' 　')::varchar(1) as serrmflg,  -- 右blank
        rtrim(haiybknssrj,' 　')::varchar(1) as haiybknssrj,  -- 右blank
        rtrim(haiybknsjji,' 　')::varchar(14) as haiybknsjji,  -- 右blank
        rtrim(haiybknserrjyoho,' 　')::varchar(85) as haiybknserrjyoho,  -- 右blank
        rtrim(mtuser,' 　')::varchar(18) as mtuser,  -- 右blank
        try_to_timestamp_ntz(rtrim(mttime,' 　'),'yyyy-mm-dd hh24:mi:ss.ff9') as mttime,  -- timestamp,右blank
        ldts,
        row_number() over(partition by ym, caltimingkbn, shamei, sno, yosokbn, yosoren order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_ktrla038zz0kadda01') }}
  {% if is_incremental() %}
      where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_haishayoubo_jpass
where aggkey = 1