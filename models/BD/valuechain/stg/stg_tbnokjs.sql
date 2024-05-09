{{ config(snowflake_warehouse='DBT_WH') }}

with stg_tbnokjs as (
    select
        rtrim(kyouhan,' 　')::varchar(5) as kyouhan,  -- 英数字
        iff(rtrim(usercd) = '','',lpad(rtrim(usercd),length(usercd),'0'))::varchar(5) as usercd,  -- コード／区分
        rtrim(hinban,' 　')::varchar(20) as hinban,  -- 英数字
        rtrim(mkbn,' 　')::varchar(1) as mkbn,  -- 英数字
        iff(rtrim(nyukkten) = '','',lpad(rtrim(nyukkten),length(nyukkten),'0'))::varchar(2) as nyukkten,  -- コード／区分
        rtrim(jchuymd,' 　')::varchar(8) as jchuymd,  -- 英数字
        to_decimal(iff(rtrim(renban) = '',0,rtrim(renban)))::decimal(1) as renban,  -- 数量／金額／数値
        rtrim(shitei,' 　')::varchar(8) as shitei,  -- 英数字
        iff(rtrim(jchutime) = '','',lpad(rtrim(jchutime),length(jchutime),'0'))::varchar(4) as jchutime,  -- 時間
        rtrim(jdenno,' 　')::varchar(6) as jdenno,  -- 英数字
        rtrim(chumon,' 　')::varchar(5) as chumon,  -- 英数字
        iff(rtrim(bokten) = '','',lpad(rtrim(bokten),length(bokten),'0'))::varchar(2) as bokten,  -- コード／区分
        iff(rtrim(skankten) = '','',lpad(rtrim(skankten),length(skankten),'0'))::varchar(2) as skankten,  -- コード／区分
        iff(rtrim(inkten) = '','',lpad(rtrim(inkten),length(inkten),'0'))::varchar(2) as inkten,  -- コード／区分
        rtrim(jchukbn,' 　')::varchar(1) as jchukbn,  -- 英数字
        iff(rtrim(nouhkbn) = '','',lpad(rtrim(nouhkbn),length(nouhkbn),'0'))::varchar(1) as nouhkbn,  -- コード／区分
        iff(rtrim(flnouhkbn) = '','',lpad(rtrim(flnouhkbn),length(flnouhkbn),'0'))::varchar(1) as flnouhkbn,  -- コード／区分
        rtrim(jtantou,' 　')::varchar(5) as jtantou,  -- 英数字
        rtrim(utantou,' 　')::varchar(2) as utantou,  -- 英数字
        iff(rtrim(denk) = '','',lpad(rtrim(denk),length(denk),'0'))::varchar(2) as denk,  -- コード／区分
        rtrim(flcd,' 　')::varchar(1) as flcd,  -- 英数字
        rtrim(remark1,' 　')::varchar(10) as remark1,  -- 英数字
        rtrim(remark2,' 　')::varchar(10) as remark2,  -- 英数字
        rtrim(riyuu,' 　')::varchar(3) as riyuu,  -- 英数字
        -- インシデントNo19対応（00000はブランクで結合する）
        iff(rtrim(kasyuu, 0) = '','',lpad(rtrim(kasyuu),length(kasyuu),'0'))::varchar(5) as kasyuu,  -- コード／区分
        iff(rtrim(hanf) = '','',lpad(rtrim(hanf),length(hanf),'0'))::varchar(1) as hanf,  -- フラグ
        rtrim(urikbn,' 　')::varchar(1) as urikbn,  -- 英数字
        rtrim(urisflg,' 　')::varchar(1) as urisflg,  -- 英数字
        iff(rtrim(genkacd) = '','',lpad(rtrim(genkacd),length(genkacd),'0'))::varchar(1) as genkacd,  -- コード／区分
        to_decimal(iff(rtrim(pricekn) = '',0,
                   concat(rtrim("PRICEKN-S",' 　'), rtrim(pricekn))))::decimal(7) as pricekn,  -- 数量／金額／数値
        to_decimal(iff(rtrim(nouhbaik) = '',0,
                   concat(rtrim("NOUHBAIK-S",' 　'), rtrim(nouhbaik))))::decimal(7) as nouhbaik,  -- 数量／金額／数値
        to_decimal(iff(rtrim(tekibaik) = '',0,
                   concat(rtrim("TEKIBAIK-S",' 　'), rtrim(tekibaik))))::decimal(7) as tekibaik,  -- 数量／金額／数値
        to_decimal(iff(rtrim(pricelp) = '',0,
                   concat(rtrim("PRICELP-S",' 　'), rtrim(pricelp))))::decimal(7) as pricelp,  -- 数量／金額／数値
        rtrim(zanteikk,' 　')::varchar(1) as zanteikk,  -- 英数字
        rtrim(kclas,' 　')::varchar(2) as kclas,  -- 英数字
        iff(rtrim(hinsij) = '','',lpad(rtrim(hinsij),length(hinsij),'0'))::varchar(1) as hinsij,  -- コード／区分
        iff(rtrim(tanteki) = '','',lpad(rtrim(tanteki),length(tanteki),'0'))::varchar(3) as tanteki,  -- コード／区分
        iff(rtrim(sshinmok) = '','',lpad(rtrim(sshinmok),length(sshinmok),'0'))::varchar(2) as sshinmok,  -- コード／区分
        rtrim(gaitoles,' 　')::varchar(1) as gaitoles,  -- 英数字
        iff(rtrim(pkanflg) = '','',lpad(rtrim(pkanflg),length(pkanflg),'0'))::varchar(1) as pkanflg,  -- フラグ
        rtrim(bunricd,' 　')::varchar(1) as bunricd,  -- 英数字
        rtrim(nyukayd,' 　')::varchar(8) as nyukayd,  -- 英数字
        iff(rtrim(nyutime) = '','',lpad(rtrim(nyutime),length(nyutime),'0'))::varchar(4) as nyutime,  -- 時間
        rtrim(nyukayk,' 　')::varchar(1) as nyukayk,  -- 英数字
        rtrim(daihin,' 　')::varchar(20) as daihin,  -- 英数字
        rtrim(daimkbn,' 　')::varchar(1) as daimkbn,  -- 英数字
        to_decimal(iff(rtrim(jchusu) = '',0,
                   concat(rtrim("JCHUSU-S",' 　'), rtrim(jchusu))))::decimal(5) as jchusu,  -- 数量／金額／数値
        rtrim(hchuhzaikbn,' 　')::varchar(1) as hchuhzaikbn,  -- 英数字
        rtrim(hchuymd,' 　')::varchar(8) as hchuymd,  -- 英数字
        iff(rtrim(hisouktn) = '','',lpad(rtrim(hisouktn),length(hisouktn),'0'))::varchar(2) as hisouktn,  -- コード／区分
        rtrim(syakptn,' 　')::varchar(1) as syakptn,  -- 英数字
        rtrim(syakkbn,' 　')::varchar(1) as syakkbn,  -- 英数字
        rtrim(hbinno,' 　')::varchar(4) as hbinno,  -- 英数字
        iff(rtrim(syukkbn) = '','',lpad(rtrim(syukkbn),length(syukkbn),'0'))::varchar(1) as syukkbn,  -- コード／区分
        iff(rtrim(syukktn) = '','',lpad(rtrim(syukktn),length(syukktn),'0'))::varchar(2) as syukktn,  -- コード／区分
        rtrim(nokiuri,' 　')::varchar(8) as nokiuri,  -- 英数字
        rtrim(syuka,' 　')::varchar(8) as syuka,  -- 英数字
        rtrim(binno,' 　')::varchar(4) as binno,  -- 英数字
        iff(rtrim(hkwatasitm) = '','',lpad(rtrim(hkwatasitm),length(hkwatasitm),'0'))::varchar(4) as hkwatasitm,  -- 時間
        rtrim(nokikbn,' 　')::varchar(1) as nokikbn,  -- 英数字
        rtrim(hkkanymd,' 　')::varchar(8) as hkkanymd,  -- 英数字
        iff(rtrim(hkkantime) = '','',lpad(rtrim(hkkantime),length(hkkantime),'0'))::varchar(4) as hkkantime,  -- 時間
        rtrim(syukknoymd,' 　')::varchar(8) as syukknoymd,  -- 英数字
        iff(rtrim(syukknotime) = '','',lpad(rtrim(syukknotime),length(syukknotime),'0'))::varchar(4) as syukknotime,  -- 時間
        iff(rtrim(defkaito) = '','',lpad(rtrim(defkaito),length(defkaito),'0'))::varchar(1) as defkaito,  -- フラグ
        rtrim(syoriflg,' 　')::varchar(1) as syoriflg,  -- 英数字
        rtrim(motokyouhan,' 　')::varchar(5) as motokyouhan,  -- 英数字
        iff(rtrim(motousercd) = '','',lpad(rtrim(motousercd),length(motousercd),'0'))::varchar(5) as motousercd,  -- コード／区分
        rtrim(buturyuflg,' 　')::varchar(1) as buturyuflg,  -- 英数字
        rtrim(kakakuskb,' 　')::varchar(1) as kakakuskb,  -- 英数字
        rtrim(nokiknflg,' 　')::varchar(1) as nokiknflg,  -- 英数字
        iff(rtrim(skbseq) = '','',lpad(rtrim(skbseq),length(skbseq),'0'))::varchar(9) as skbseq,  -- コード／区分
        iff(rtrim(dainohin) = '','',lpad(rtrim(dainohin),length(dainohin),'0'))::varchar(1) as dainohin,  -- コード／区分
        iff(rtrim(dailblumu) = '','',lpad(rtrim(dailblumu),length(dailblumu),'0'))::varchar(1) as dailblumu,  -- コード／区分
        rtrim(noudaiseq,' 　')::varchar(5) as noudaiseq,  -- 英数字
        to_decimal(iff(rtrim(bincount) = '',0,rtrim(bincount)))::decimal(4) as bincount,  -- 数量／金額／数値
        rtrim(binbinno,' 　')::varchar(4) as binbinno,  -- 英数字
        rtrim(binsimet,' 　')::varchar(4) as binsimet,  -- 英数字
        rtrim(binsamcd,' 　')::varchar(3) as binsamcd,  -- 英数字
        rtrim(binsyuarer,' 　')::varchar(1) as binsyuarer,  -- 英数字
        rtrim(jyurjflg,' 　')::varchar(1) as jyurjflg,  -- 英数字
        iff(rtrim(tsyukymd) = '','',lpad(rtrim(tsyukymd),length(tsyukymd),'0'))::varchar(8) as tsyukymd,  -- 日付
        rtrim(kakuhositei,' 　')::varchar(1) as kakuhositei,  -- 英数字
        rtrim(honbuigai,' 　')::varchar(1) as honbuigai,  -- 英数字
        ldts, -- b層のldts
        rank() over (
                partition by
                    kyouhan,
                    usercd,
                    hinban,
                    mkbn,
                    nyukkten,
                    concat(left(chumon, 1), right(chumon, 3)),
                    jchuymd
                order by substr(chumon, 2, 1) desc, ldts desc
            ) aggkey
        from {{ ref('substr_tbnokjs') }}
    )
select *
from stg_tbnokjs
where aggkey = 1