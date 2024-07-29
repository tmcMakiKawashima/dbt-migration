{{ config(snowflake_warehouse='DBT_WH') }}

with temp45 as (
    select * from {{ref('tmp45_dm_tmc_ippan_jutyunokikaito')}}
),
nyusyukko as (
    select
        max(
            lpad(rtrim("SDATE-Y"),length("SDATE-Y"),'0') ||
            lpad(rtrim("SDATE-M"),length("SDATE-M"),'0') ||
            lpad(rtrim("SDATE-D"),length("SDATE-D"),'0') 
           ) nyukoymd, -- 処理日付（入庫日）
        kyouhan kyouhan_nyuko, -- 共販店コード
        hinban hinban_nyuko, -- 品番
        dennoj dennoj_nyuko, -- 伝票№ 自拠点(イシュ№）
        lpad(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
        lpad(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
        lpad(rtrim("JDATE-D"),length("JDATE-D"),'0') 
         jdate_nyuko, -- 受注日
        chokso, -- 一般直送区分
        ukekten ukekten_nyuko, -- 受入拠点
        right(remark2, 5) chumon_no_nyuko, --リマーク２ ※右から5桁
        substr(remark2, 1, 2) ordersyu_nyuko, --リマーク２　※先頭2桁
        makercd --メーカーコード
    from {{ ref('stg_tbnsyus') }} -- 入出庫ファイル
    where gdenk in ('71', '72', '73', '74', '75', '78') -- 外部伝区
    and dsyubets = '6' -- データ種別:内部伝区
    group by all
)
select
     temp45.*,
     nyusyukko.nyukoymd
from temp45
left outer join nyusyukko
on substr(temp45.dlrcd, 1, 5) || iff(temp45.nyukkten is not null, temp45.nyukkten, temp45.kyoten)
   = nyusyukko.kyouhan_nyuko || nyusyukko.ukekten_nyuko -- 仕向先CD||（入庫）拠点CD/共販店CD||受入拠点
and temp45.ordeno = nyusyukko.chumon_no_nyuko -- 注文NO/right(リマーク2,5)
and temp45.shinban = nyusyukko.hinban_nyuko -- 出荷品番/品番
and temp45.syukkaymd = nyusyukko.jdate_nyuko -- 出荷日/受注日
and temp45.denno = nyusyukko.dennoj_nyuko -- ケースNO/伝票№ 自拠点(イシュ№）