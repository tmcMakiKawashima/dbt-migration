with nyusyukko as (
    select
        KYOUHAN KYOUHAN_NYUKO, -- 共販店コード
        HINBAN HINBAN_NYUKO, -- 品番
        DENNOJ DENNOJ_NYUKO, -- 伝票№ 自拠点(イシュ№）
        SUM(SYUKAJ) NYUKOSU, -- 更新数  自拠点出荷処理数
        MAX(
            LPAD(rtrim("SDATE-Y"),length("SDATE-Y"),'0') ||
            LPAD(rtrim("SDATE-M"),length("SDATE-M"),'0') ||
            LPAD(rtrim("SDATE-D"),length("SDATE-D"),'0') 
           ) NYUKOYMD, -- 処理日付
        LPAD(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
        LPAD(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
        LPAD(rtrim("JDATE-D"),length("JDATE-D"),'0') 
         JDATE_NYUKO, -- 受注日
        UKEKTEN UKEKTEN_NYUKO, -- 受入拠点
        RIGHT(REMARK2, 5) CHUMON_NO_NYUKO --リマーク２ ※右から5桁目
    from {{ ref('stg_tbnsyus') }} -- 入出庫ファイル
    where GDENK in ('71', '72', '73', '74', '75', '78') -- 外部伝区
    and DSYUBETS = '6' -- データ種別:内部伝区
    group by
            KYOUHAN, -- 共販店コード
            HINBAN, -- 品番
            DENNOJ, -- 伝票№ 自拠点(イシュ№）
            JDATE_NYUKO , -- 受注日
            CHOKSO, -- 一般直送区分
            UKEKTEN, -- 受入拠点
            CHUMON_NO_NYUKO -- リマーク２ ※右から5桁目
),
shimuke as (
    select * from {{ref('stg_tbsmksk')}} -- 仕向先テーブル
    )
select 
     nyusyukko.KYOUHAN_NYUKO -- 共販店コード
    ,nyusyukko.HINBAN_NYUKO -- 品番
    ,nyusyukko.DENNOJ_NYUKO -- 伝票№ 自拠点(イシュ№）
    ,nyusyukko.NYUKOSU -- 入庫数
    ,nyusyukko.NYUKOYMD -- 入庫日
    ,nyusyukko.JDATE_NYUKO -- 受注日
    ,nyusyukko.CHUMON_NO_NYUKO --リマーク２ ※右から5桁目
    -- 支社コード ※[入出庫ファイル]共販店コード　＋　[TAS仕向先テーブル]支社コード
    ,nyusyukko.KYOUHAN_NYUKO || shimuke.SISHACD SHIMUKESAKI_NYUKO
    ,shimuke.KYOUHAN as check_KYOUHAN --共販店コード nullチェック用
from nyusyukko
left outer join shimuke
on nyusyukko.KYOUHAN_NYUKO = shimuke.KYOUHAN -- 共販店コード
and nyusyukko.UKEKTEN_NYUKO = shimuke.KYOTEN -- 受入拠点/入庫拠点