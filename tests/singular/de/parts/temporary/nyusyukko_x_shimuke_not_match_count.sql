{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          KYOUHAN, -- 共販店コード
          HINBAN, -- 品番
          DENNOJ, -- 伝票№ 自拠点(イシュ№）
          LPAD(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
          LPAD(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
          LPAD(rtrim("JDATE-D"),length("JDATE-D"),'0') 
          JDATE_NYUKO, -- 受注日
          CHOKSO, -- 一般直送区分
          UKEKTEN, -- 受入拠点
          RIGHT(REMARK2, 5) CHUMON_NO_NYUKO --リマーク２ ※右から5桁目
        from {{ ref('stg_tbnsyus') }}
        where GDENK in ('71', '72', '73', '74', '75', '78') -- 外部伝区
        and DSYUBETS = '6' -- データ種別:内部伝区
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref('nyusyukko_x_shimuke')}}
    ) b