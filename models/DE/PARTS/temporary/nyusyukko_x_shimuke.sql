with nyusyukko as (
    select
        KYOUHAN KYOUHAN_NYUKO, -- 共販店コード★リネームいる？
        HINBAN HINBAN_NYUKO, -- 品番
        DENNOJ DENNOJ_NYUKO, -- 伝票№ 自拠点(イシュ№）
        SUM(SYUKAJ) NYUKOSU, -- 更新数  自拠点出荷処理数
        MAX(SDATE) NYUKOYMD, -- 処理日付
        JDATE JDATE_NYUKO, -- 受注日
        CHOKSO CHOKSO_NYUKO, -- 一般直送区分
        UKEKTEN UKEKTEN_NYUKO, -- 受入拠点
        -- ★設計書に記載なし：RIGHT(リマーク2,5)（結合条件に使用）
        RIGHT(REMARK2, 5) CHUMON_NO_NYUKO
    from {{ ref('stg_tbnsyus') }} -- 入出庫ファイル
    where GDENK in ('71', '72', '73', '74', '75', '78') -- 外部伝区
    and DSYUBETS = '6' -- データ種別:内部伝区
    group by
            KYOUHAN, -- 共販店コード
            HINBAN, -- 品番
            DENNOJ, -- 伝票№ 自拠点(イシュ№）
            JDATE, -- 受注日
            CHOKSO, -- 一般直送区分
            UKEKTEN, -- 受入拠点
            REMARK2 -- リマーク２
),
shimuke as (
    select * from {{ref('stg_tbsmksk')}} -- 仕向先テーブル
    )
select 
     nyusyukko.*
    ,shimuke.SISHACD -- 支社コード
    -- ★設計書に記載なし：共販店コード＋支社コード（結合条件に使用）
    ,nyusyukko.KYOUHAN_NYUKO || shimuke.SISHACD SHIMUKESAKI_NYUKO
from nyusyukko
left outer join shimuke
on nyusyukko.KYOUHAN_NYUKO = shimuke.KYOUHAN -- 共販店コード
and nyusyukko.UKEKTEN_NYUKO = shimuke.KYOTEN -- 受入/入庫拠点