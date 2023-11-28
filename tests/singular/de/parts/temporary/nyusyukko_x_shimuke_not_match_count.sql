{{ config(fail_calc = "cnt") }}
-- データ結合４のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          kyouhan, -- 共販店コード
          hinban, -- 品番
          dennoj, -- 伝票№ 自拠点(イシュ№）
          lpad(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
          lpad(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
          lpad(rtrim("JDATE-D"),length("JDATE-D"),'0') 
          jdate_nyuko, -- 受注日
          chokso, -- 一般直送区分
          ukekten, -- 受入拠点
          right(remark2, 5) chumon_no_nyuko, --リマーク２ ※右から5桁目
          substr(remark2, 1, 2) ordersyu_nyuko, --リマーク２　※先頭2桁
          makercd --メーカーコード
        from {{ ref('stg_tbnsyus') }}
        where gdenk in ('71', '72', '73', '74', '75', '78') -- 外部伝区
        and dsyubets = '6' -- データ種別:内部伝区
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref('nyusyukko_x_shimuke')}}
    ) b