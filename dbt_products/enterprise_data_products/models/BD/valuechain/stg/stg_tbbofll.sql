{{ config(snowflake_warehouse='DBT_WH') }}

with stg_tbbofll as (
    select
      rtrim(kyouhan, ' 　')::varchar(5) as kyouhan, --英数字
      rtrim(hinban, ' 　')::varchar(20) as hinban, --英数字
      rtrim(mkbn, ' 　')::varchar(1) as mkbn, --英数字
      iff(rtrim(nyukkten) = '', '', lpad(rtrim(nyukkten), length(nyukkten), '0'))::varchar(2)as nyukkten, --コード/区分
      iff(rtrim(jchuymd) = '', '', lpad(rtrim(jchuymd), length(jchuymd), '0'))::varchar(8)as jchuymd, --日付
      iff(rtrim(jchutime) = '', '', lpad(rtrim(jchutime), length(jchutime), '0'))::varchar(4)as jchutime, --時間
      rtrim(jdenno, ' 　')::varchar(6) as jdenno, --英数字
      rtrim(chumon, ' 　')::varchar(5) as chumon, --英数字
      iff(rtrim(bokten) = '', '', lpad(rtrim(bokten), length(bokten), '0'))::varchar(2)as bokten, --コード/区分
      iff(rtrim(skankten) = '', '', lpad(rtrim(skankten), length(skankten), '0'))::varchar(2)as skankten, --コード/区分
      iff(rtrim(usercd) = '', '', lpad(rtrim(usercd), length(usercd), '0'))::varchar(5)as usercd, --コード/区分
      iff(rtrim(inkten) = '', '', lpad(rtrim(inkten), length(inkten), '0'))::varchar(2)as inkten, --コード/区分
      rtrim(jchukbn, ' 　')::varchar(1) as jchukbn, --英数字
      iff(rtrim(nouhkbn) = '', '', lpad(rtrim(nouhkbn), length(nouhkbn), '0'))::varchar(1)as nouhkbn, --コード/区分
      iff(rtrim(flnouhkbn) = '', '', lpad(rtrim(flnouhkbn), length(flnouhkbn), '0'))::varchar(1)as flnouhkbn, --コード/区分
      rtrim(jtantou, ' 　')::varchar(5) as jtantou, --英数字
      rtrim(utantou, ' 　')::varchar(2) as utantou, --英数字
      iff(rtrim(denk) = '', '', lpad(rtrim(denk), length(denk), '0'))::varchar(2)as denk, --コード/区分
      rtrim(flcd, ' 　')::varchar(1) as flcd, --英数字
      rtrim(remark1, ' 　')::varchar(10) as remark1, --英数字
      rtrim(remark2, ' 　')::varchar(10) as remark2, --英数字
      rtrim(riyuu, ' 　')::varchar(3) as riyuu, --英数字
      iff(rtrim(setymd) = '', '', lpad(rtrim(setymd), length(setymd), '0'))::varchar(8)as setymd, --日付
      iff(rtrim(kasisakiu) = '', '', lpad(rtrim(kasisakiu), length(kasisakiu), '0'))::varchar(5)as kasisakiu, --コード区分
      iff(rtrim(kasyuu, 0) = '', '', lpad(rtrim(kasyuu), length(kasyuu), '0'))::varchar(5)as kasyuu, --コード区分
      iff(rtrim(c80flg) = '', '', lpad(rtrim(c80flg), length(c80flg), '0'))::varchar(1)as c80flg, --フラグ
      rtrim(urikbn, ' 　')::varchar(1) as urikbn, --英数字
      rtrim(urisflg, ' 　')::varchar(1) as urisflg, --英数字
      iff(rtrim(genkacd) = '', '', lpad(rtrim(genkacd), length(genkacd), '0'))::varchar(1)as genkacd, --コード/区分
      to_decimal(iff(rtrim(pricekn) = '', 0,
                 concat(rtrim("PRICEKN-S", ' 　'), rtrim(pricekn))))::decimal(7)as pricekn, --数量/金額/数値
      to_decimal(iff(rtrim(nouhbaik) = '', 0,
                 concat(rtrim("NOUHBAIK-S", ' 　'), rtrim(nouhbaik))))::decimal(7)as nouhbaik, --数量/金額/数値
      to_decimal(iff(rtrim(tekibaik) = '', 0,
                 concat(rtrim("TEKIBAIK-S", ' 　'), rtrim(tekibaik))))::decimal(7)as tekibaik, --数量/金額/数値
      to_decimal(iff(rtrim(pricelp) = '', 0,
                 concat(rtrim("PRICELP-S", ' 　'), rtrim(pricelp))))::decimal(7)as pricelp, --数量/金額/数値
      rtrim(zanteikk, ' 　')::varchar(1) as zanteikk, --英数字
      rtrim(kclas, ' 　')::varchar(2) as kclas, --英数字
      iff(rtrim(hinsij) = '', '', lpad(rtrim(hinsij), length(hinsij), '0'))::varchar(1)as hinsij, --コード/区分
      iff(rtrim(tanteki) = '', '', lpad(rtrim(tanteki), length(tanteki), '0'))::varchar(3)as tanteki, --コード/区分
      iff(rtrim(sshinmok) = '', '', lpad(rtrim(sshinmok), length(sshinmok), '0'))::varchar(2)as sshinmok, --コード/区分
      rtrim(gaitoles, ' 　')::varchar(1) as gaitoles, --英数字
      iff(rtrim(pkanflg) = '', '', lpad(rtrim(pkanflg), length(pkanflg), '0'))::varchar(1)as pkanflg, --フラグ
      rtrim(bunricd, ' 　')::varchar(1) as bunricd, --英数字
      iff(rtrim(nyukayd) = '', '', lpad(rtrim(nyukayd), length(nyukayd), '0'))::varchar(8)as nyukayd,  --日付
      iff(rtrim(nyutime) = '', '', lpad(rtrim(nyutime), length(nyutime), '0'))::varchar(4)as nyutime, --時間
      rtrim(nyukayk, ' 　')::varchar(1) as nyukayk, --英数字
      rtrim(daihin, ' 　')::varchar(20) as daihin, --英数字
      rtrim(daimkbn, ' 　')::varchar(1) as daimkbn, --英数字
      to_decimal(iff(rtrim(jchusu) = '', 0,
                 concat(rtrim("JCHUSU-S", ' 　'), rtrim(jchusu))))::decimal(5)as jchusu, --数量/金額/数値
      to_decimal(iff(rtrim(bosu) = '', 0,
                 concat(rtrim("BOSU-S", ' 　'), rtrim(bosu))))::decimal(5)as bosu, --数量/金額/数値
      rtrim(zensuflg, ' 　')::varchar(1) as zensuflg, --英数字
      to_decimal(iff(rtrim(syukkei) = '', 0,
                 concat(rtrim("SYUKKEI-S", ' 　'), rtrim(syukkei))))::decimal(5)as syukkei, --数量/金額/数値
      to_decimal(iff(rtrim(hkyyksu) = '', 0,
                 concat(rtrim("HKYYKSU-S", ' 　'), rtrim(hkyyksu))))::decimal(5)as hkyyksu, --数量/金額/数値
      rtrim(syukkflg, ' 　')::varchar(1) as syukkflg, --英数字
      to_decimal(iff(rtrim(bokcnt) = '', 0, rtrim(bokcnt)))::decimal(2)as bokcnt, --数量/金額/数値
      iff(rtrim(ndasiymd) = '', '', lpad(rtrim(ndasiymd), length(ndasiymd), '0'))::varchar(8)as ndasiymd, --日付
      iff(rtrim(ndasitime) = '', '', lpad(rtrim(ndasitime), length(ndasitime), '0'))::varchar(4)as ndasitime, --時間
      rtrim(syukdenno, ' 　')::varchar(6) as syukdenno, --英数字
      iff(rtrim(sasyotm) = '', '', lpad(rtrim(sasyotm), length(sasyotm), '0'))::varchar(4)as sasyotm, --時間
      iff(rtrim(mntymd) = '', '', lpad(rtrim(mntymd), length(mntymd), '0'))::varchar(8)as mntymd, --日付
      rtrim(daitaiflg, ' 　')::varchar(1) as daitaiflg, --英数字
      rtrim(ffflg, ' 　')::varchar(1) as ffflg, --英数字
      rtrim(ptopflg, ' 　')::varchar(1) as ptopflg, --英数字
      iff(rtrim(idorject) = '', '', lpad(rtrim(idorject), length(idorject), '0'))::varchar(1)as idorject,  --フラグ
      iff(rtrim(itakukbn) = '', '', lpad(rtrim(itakukbn), length(itakukbn), '0'))::varchar(1)as itakukbn, --コード/区分
      iff(rtrim(ptopseq) = '', '', lpad(rtrim(ptopseq), length(ptopseq), '0'))::varchar(11)as ptopseq, --コード/区分
      rtrim(kakakuskb, ' 　')::varchar(1) as kakakuskb, --英数字
      rtrim(njkbn, ' 　')::varchar(1) as njkbn, --英数字,
      ldts, --b層のldts
      rank() over(partition by kyouhan, hinban, mkbn, nyukkten, chumon, usercd, urisflg, jchuymd order by ldts desc) aggkey
    from {{ ref('substr_tbbofll') }}
)
select * from stg_tbbofll
where aggkey = 1