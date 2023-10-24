with stg_tbchznl as (
    select
        rtrim(kyouhan, ' 　')::varchar(5) as kyouhan, -- 英数字
        rtrim(hinban, ' 　')::varchar(20) as hinban, -- 英数字
        rtrim(mkbn, ' 　')::varchar(1) as mkbn, -- 英数字
        iff(rtrim(nyukkten) = '', '', lpad(rtrim(nyukkten), length(nyukkten), '0'))::varchar(2) as nyukkten, -- コード／区分
        rtrim(chumon, ' 　')::varchar(5) as chumon, -- 英数字
        rtrim(hinkbn, ' 　')::varchar(1) as hinkbn, -- 英数字
        iff(rtrim(genkacd) = '', '', lpad(rtrim(genkacd), length(genkacd), '0'))::varchar(1) as genkacd, -- コード／区分
        to_decimal(iff(rtrim(pricekn) = '', 0,
                    concat(rtrim("PRICEKN-S", ' 　'), rtrim(pricekn))))::decimal(7) as pricekn, -- 数量／金額／数値
        rtrim(chokso, ' 　')::varchar(1) as chokso, -- 英数字
        iff(rtrim(makercd) = '', '', lpad(rtrim(makercd), length(makercd), '0'))::varchar(5) as makercd, -- コード／区分
        rtrim(ktenkbn, ' 　')::varchar(1) as ktenkbn, -- 英数字
        rtrim(odrsbetu, ' 　')::varchar(2) as odrsbetu, -- 英数字
        rtrim(yusocd, ' 　')::varchar(1) as yusocd, -- 英数字
        iff(rtrim(bocd) = '', '', lpad(rtrim(bocd), length(bocd), '0'))::varchar(1) as bocd, -- コード／区分
        rtrim(urikbn, ' 　')::varchar(1) as urikbn, -- 英数字
        iff(rtrim(hchuymd) = '', '', lpad(rtrim(hchuymd), length(hchuymd), '0'))::varchar(8) as hchuymd, -- 日付
        iff(rtrim(hchutime) = '', '', lpad(rtrim(hchutime), length(hchutime), '0'))::varchar(4) as hchutime, -- 時間
        iff(rtrim(tosyoyd1) = '', '', lpad(rtrim(tosyoyd1), length(tosyoyd1), '0'))::varchar(8) as tosyoyd1, -- 日付
        iff(rtrim(tosyotm) = '', '', lpad(rtrim(tosyotm), length(tosyotm), '0'))::varchar(4) as tosyotm, -- 時間
        iff(rtrim(kaitoud1) = '', '', lpad(rtrim(kaitoud1), length(kaitoud1), '0'))::varchar(8) as kaitoud1, -- 日付
        iff(rtrim(syukayd1) = '', '', lpad(rtrim(syukayd1), length(syukayd1), '0'))::varchar(8) as syukayd1, -- 日付
        iff(rtrim(syukatm1) = '', '', lpad(rtrim(syukatm1), length(syukatm1), '0'))::varchar(4) as syukatm1, -- 時間
        iff(rtrim(nyukayd1) = '', '', lpad(rtrim(nyukayd1), length(nyukayd1), '0'))::varchar(8) as nyukayd1, -- 日付
        iff(rtrim(nyukatm1) = '', '', lpad(rtrim(nyukatm1), length(nyukatm1), '0'))::varchar(4) as nyukatm1, -- 時間
        rtrim(nyukayk1, ' 　')::varchar(1) as nyukayk1, -- 英数字
        iff(rtrim(kaitoud2) = '', '', lpad(rtrim(kaitoud2), length(kaitoud2), '0'))::varchar(8) as kaitoud2, -- 日付
        iff(rtrim(syukayd2) = '', '', lpad(rtrim(syukayd2), length(syukayd2), '0'))::varchar(8) as syukayd2, -- 日付
        iff(rtrim(syukatm2) = '', '', lpad(rtrim(syukatm2), length(syukatm2), '0'))::varchar(4) as syukatm2, -- 時間
        iff(rtrim(nyukayd2) = '', '', lpad(rtrim(nyukayd2), length(nyukayd2), '0'))::varchar(8) as nyukayd2, -- 日付
        iff(rtrim(nyukatm2) = '', '', lpad(rtrim(nyukatm2), length(nyukatm2), '0'))::varchar(4) as nyukatm2, -- 時間
        rtrim(nyukayk2, ' 　')::varchar(1) as nyukayk2, -- 英数字
        iff(rtrim(kaitoud3) = '', '', lpad(rtrim(kaitoud3), length(kaitoud3), '0'))::varchar(8) as kaitoud3, -- 日付
        iff(rtrim(syukayd3) = '', '', lpad(rtrim(syukayd3), length(syukayd3), '0'))::varchar(8) as syukayd3, -- 日付
        iff(rtrim(syukatm3) = '', '', lpad(rtrim(syukatm3), length(syukatm3), '0'))::varchar(4) as syukatm3, -- 時間
        iff(rtrim(nyukayd3) = '', '', lpad(rtrim(nyukayd3), length(nyukayd3), '0'))::varchar(8) as nyukayd3, -- 日付
        iff(rtrim(nyukatm3) = '', '', lpad(rtrim(nyukatm3), length(nyukatm3), '0'))::varchar(4) as nyukatm3, -- 時間
        rtrim(nyukayk3, ' 　')::varchar(1) as nyukayk3, -- 英数字
        iff(rtrim(kaitoud4) = '', '', lpad(rtrim(kaitoud4), length(kaitoud4), '0'))::varchar(8) as kaitoud4, -- 日付
        iff(rtrim(syukayd4) = '', '', lpad(rtrim(syukayd4), length(syukayd4), '0'))::varchar(8) as syukayd4, -- 日付
        iff(rtrim(syukatm4) = '', '', lpad(rtrim(syukatm4), length(syukatm4), '0'))::varchar(4) as syukatm4, -- 時間
        iff(rtrim(nyukayd4) = '', '', lpad(rtrim(nyukayd4), length(nyukayd4), '0'))::varchar(8) as nyukayd4, -- 日付
        iff(rtrim(nyukatm4) = '', '', lpad(rtrim(nyukatm4), length(nyukatm4), '0'))::varchar(4) as nyukatm4, -- 時間
        rtrim(nyukayk4, ' 　')::varchar(1) as nyukayk4, -- 英数字
        to_decimal(iff(rtrim(hchusu) = '', 0,
                    concat(rtrim("HCHUSU-S", ' 　'), rtrim(hchusu))))::decimal(5) as hchusu, -- 数量／金額／数値
        to_decimal(iff(rtrim(mitesu) = '', 0,
                    concat(rtrim("MITESU-S", ' 　'), rtrim(mitesu))))::decimal(5) as mitesu, -- 数量／金額／数値
        to_decimal(iff(rtrim(nyukkei) = '', 0,
                    concat(rtrim("NYUKKEI-S", ' 　'), rtrim(nyukkei))))::decimal(5) as nyukkei, -- 数量／金額／数値
        rtrim(nyukkflg, ' 　')::varchar(1) as nyukkflg, -- 英数字
        to_decimal(iff(rtrim(chuzancnt) = '', 0, rtrim(chuzancnt)))::decimal(2) as chuzancnt, -- 数量／金額／数値
        iff(rtrim(nnyukymd) = '', '', lpad(rtrim(nnyukymd), length(nnyukymd), '0'))::varchar(8) as nnyukymd, -- 日付
        iff(rtrim(nnyuktm) = '', '', lpad(rtrim(nnyuktm), length(nnyuktm), '0'))::varchar(4) as nnyuktm, -- 時間
        to_decimal(iff(rtrim(mkszumcnt) = '', 0, rtrim(mkszumcnt)))::decimal(1) as mkszumcnt, -- 数量／金額／数値
        iff(rtrim(mntymd) = '', '', lpad(rtrim(mntymd), length(mntymd), '0'))::varchar(8) as mntymd, -- 日付
        rtrim(ptopflg, ' 　')::varchar(1) as ptopflg, -- 英数字
        iff(rtrim(tensokbn) = '', '', lpad(rtrim(tensokbn), length(tensokbn), '0'))::varchar(1) as tensokbn, -- コード／区分
        rtrim(tehaiok, ' 　')::varchar(1) as tehaiok, -- 英数字
        iff(rtrim(ltnyukayd) = '', '', lpad(rtrim(ltnyukayd), length(ltnyukayd), '0'))::varchar(8) as ltnyukayd, -- 日付
        iff(rtrim(ltsyukayd) = '', '', lpad(rtrim(ltsyukayd), length(ltsyukayd), '0'))::varchar(8) as ltsyukayd, -- 日付
        ldts, -- B層のLDTS
        rank() over (partition by kyouhan, hinban, mkbn, nyukkten, chumon, makercd, hchuymd order by ldts desc) aggkey
    from {{ ref('substr_tbchznl') }}
)
select * from stg_tbchznl
where aggkey = 1
