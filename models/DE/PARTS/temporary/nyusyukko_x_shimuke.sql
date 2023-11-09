with nyusyukko as (
    select
        kyouhan kyouhan_nyuko, -- 共販店コード
        hinban hinban_nyuko, -- 品番
        dennoj dennoj_nyuko, -- 伝票№ 自拠点(イシュ№）
        sum(syukaj) nyukosu, -- 更新数  自拠点出荷処理数
        max(
            lpad(rtrim("SDATE-Y"),length("SDATE-Y"),'0') ||
            lpad(rtrim("SDATE-M"),length("SDATE-M"),'0') ||
            lpad(rtrim("SDATE-D"),length("SDATE-D"),'0') 
           ) nyukoymd, -- 処理日付
        lpad(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
        lpad(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
        lpad(rtrim("JDATE-D"),length("JDATE-D"),'0') 
         jdate_nyuko, -- 受注日
        ukekten ukekten_nyuko, -- 受入拠点
        right(remark2, 5) chumon_no_nyuko, --リマーク２ ※右から5桁目
        substr(remark2, 1, 2) ordersyu_nyuko, --リマーク２　※先頭2桁
        makercd, --メーカーコード
        chokso -- 一般直送区分
    from {{ ref('stg_tbnsyus') }} -- 入出庫ファイル
    where gdenk in ('71', '72', '73', '74', '75', '78') -- 外部伝区
    and dsyubets = '6' -- データ種別:内部伝区
    group by
            kyouhan, -- 共販店コード
            hinban, -- 品番
            dennoj, -- 伝票№ 自拠点(イシュ№）
            jdate_nyuko , -- 受注日
            chokso, -- 一般直送区分
            ukekten, -- 受入拠点
            chumon_no_nyuko, -- リマーク２ ※右から5桁目
            ordersyu_nyuko, --リマーク２ ※先頭2桁
            makercd --メーカーコード
),
shimuke as (
    select * from {{ref('stg_tbsmksk')}} -- 仕向先テーブル
    ),
shimuke_noki as (
    select * from {{ref('stg_tbsmksk_noki')}}
    where deletedate = '00000000'
)
select 
     nyusyukko.kyouhan_nyuko -- 共販店コード
    ,nyusyukko.hinban_nyuko -- 品番
    ,nyusyukko.dennoj_nyuko -- 伝票№ 自拠点(イシュ№）
    ,nyusyukko.nyukosu -- 入庫数
    ,nyusyukko.nyukoymd -- 入庫日
    ,nyusyukko.jdate_nyuko -- 受注日
    ,nyusyukko.chumon_no_nyuko --リマーク２ ※右から5桁目
    ,
    -- 納期仕向
    case 
        when
            (
                (
                    (
                        substr(nyusyukko.dennoj_nyuko, 1, 1) = 'P'
                        or substr(nyusyukko.dennoj_nyuko, 1, 1) = 'Q'
                    )
                    and not (noki.kyouhan is null)
                    and ordersyu_nyuko = '11'
                    and (noki.hikizaikbn = '1' or noki.hikizaikbn ='3')
                )
                or (
                    (
                        substr(nyusyukko.dennoj_nyuko, 1, 1) = 'P'
                        or substr(nyusyukko.dennoj_nyuko, 1, 1) = 'Q'
                    )
                    and not (noki.kyouhan is null)
                    and ordersyu_nyuko = '12'
                    and (noki.hikizaikbn = '2' or noki.hikizaikbn = '3')
                )
            )
        then
            noki.nokismkskcd
        else
            shimuke.sishacd
    end as sishacd --支社コード
    --
    ,nyusyukko.chokso -- 一般直送区分
    ,nyusyukko.ukekten_nyuko -- 受入拠点
    ,nyusyukko.makercd --メーカーコード
    ,shimuke.kyouhan as check_kyouhan --共販店コード nullチェック用
from nyusyukko
left outer join shimuke
on nyusyukko.kyouhan_nyuko = shimuke.kyouhan -- 共販店コード
and nyusyukko.ukekten_nyuko = shimuke.kyoten -- 受入拠点/拠点コード
left outer join shimuke_noki noki
on nyusyukko.kyouhan_nyuko = noki.kyouhan --共販店コード
and nyusyukko.ukekten_nyuko = noki.nyukkten --受入拠点/入庫拠点
and nyusyukko.makercd = noki.makercd --メーカーコード
and 
    case
        when nyusyukko.makercd <> '70000'
            then '' = noki.ktenkbn
        else 1
    end --拠点区分