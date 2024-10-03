{{ config(
      materialized='incremental',
      unique_key = ['kbsyadai', 'nosyadai', 'ddtorituke', 'cdyouhinban', 'cdtorihan', 'cdtoritenpo'],
      incremental_strategy = 'merge'
   ) }}

with stg_yohinsotyakureki as (
    select
        kbsyadai::varchar(3) as kbsyadai, -- なし
        rtrim(nosyadai, ' 　')::varchar(20) as nosyadai, -- 右ブランク
        split_part(nosyadai, '-', 1) as syadai_kt, -- 車台番号ハイフンの左
        split_part(rtrim(nosyadai, ' 　'), '-', 2) as frmno, -- 車台番号(trim後）ハイフンの右
        rtrim(ddtorituke, ' 　')::varchar(8) as ddtorituke,-- 右ブランク
        rtrim(cdyouhinban, ' 　')::varchar(15) as cdyouhinban, -- 右ブランク
        rtrim(cdtorihan, ' 　')::varchar(5) as cdtorihan, -- 右ブランク
        rtrim(cdtoritenpo, ' 　')::varchar(3) as cdtoritenpo, -- 右ブランク
        to_number(iff(ltrim(suuryou, '0 　') = '', '0', ltrim(suuryou, '0')))::number(2) as suuryou, -- 左ゼロ
        to_number(iff(ltrim(kmtrtsok, '0 　') = '', '0', ltrim(kmtrtsok, '0')))::number(3) as kmtrtsok, -- 左ゼロ
        rtrim(kbsinsa, ' 　')::varchar(1) as kbsinsa, -- 右ブランク
        ldts, -- b層のldts
        line_number,
        rank() over (partition by kbsyadai, nosyadai, ddtorituke, cdyouhinban, cdtorihan, cdtoritenpo order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3201') }}
           {% if is_incremental() %}
               where ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * exclude(aggkey, line_number) from stg_yohinsotyakureki
where aggkey = 1