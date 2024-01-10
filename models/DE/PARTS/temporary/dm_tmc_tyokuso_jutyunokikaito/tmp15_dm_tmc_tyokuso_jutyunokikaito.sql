with temp10 as (
    select * from {{ref('tmp10_dm_tmc_tyokuso_jutyunokikaito')}}
),
nyusyukko as (
    select
        kyouhan kyouhan_nyuko, -- 共販店コード
        hinban hinban_nyuko, -- 品番
        dennoj dennoj_nyuko, -- 伝票No.自拠点（イシュNo.)
        lpad(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
        lpad(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
        lpad(rtrim("JDATE-D"),length("JDATE-D"),'0') 
         jdate_nyuko, -- 受注日
        chokso, -- 一般直送区分
        ukekten ukekten_nyuko, -- 受入拠点
        right(remark2, 5) chumon_no_nyuko, -- 注文No.（リマーク２　右から５桁）
        substr(remark2, 1, 2) ordersyu_nyuko, -- オーダー種別（リマーク２ 先頭2桁）
        makercd, -- メーカーコード
        max(
            lpad(rtrim("SDATE-Y"),length("SDATE-Y"),'0') ||
            lpad(rtrim("SDATE-M"),length("SDATE-M"),'0') ||
            lpad(rtrim("SDATE-D"),length("SDATE-D"),'0') 
           ) nyukoymd -- 処理日付
    from {{ref('stg_tbnsyus')}} -- 入出庫ファイル
    where gdenk in ('71', '72', '73', '74', '75', '78') -- 外部伝区
    and dsyubets = '6' -- データ種別:内部伝区
    group by
        kyouhan, --共販店コード
        hinban, -- 品番
        dennoj, --伝票No.自拠点（イシュNo.)
        jdate_nyuko, -- 受注日
        chokso, -- 一般直送区分
        ukekten, -- 受入拠点
        chumon_no_nyuko, -- 注文No.（リマーク２　右から５桁）
        ordersyu_nyuko, -- オーダー種別（リマーク２ 先頭2桁）
        makercd -- メーカーコード
)
select
    temp10.*,
    nyusyukko.nyukoymd -- 入庫日
from temp10
left outer join nyusyukko
on substr(temp10.dlrcd, 1, 5) || iff(temp10.nyukkten is not null, temp10.nyukkten, temp10.kyoten) = nyusyukko.kyouhan_nyuko || nyusyukko.ukekten_nyuko
and temp10.ordeno = nyusyukko.chumon_no_nyuko -- オーダーNO/リマーク２の末尾5桁
and temp10.shinban = nyusyukko.hinban_nyuko -- 出荷品番/品番
and temp10.syukkaymd = nyusyukko.jdate_nyuko -- 出荷日/受注日
and temp10.sirissueno = nyusyukko.dennoj_nyuko -- 仕入先ISSUE_NO/伝票No.自拠点（イシュNo.）