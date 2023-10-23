with stg_tbbofll as (
    select
      rtrim(KYOUHAN, ' 　')::VARCHAR(5) as KYOUHAN, --英数字
      rtrim(HINBAN, ' 　')::VARCHAR(20) as HINBAN, --英数字
      rtrim(MKBN, ' 　')::VARCHAR(1) as MKBN, --英数字
      IFF(rtrim(NYUKKTEN) = '', '', LPAD(rtrim(NYUKKTEN), length(NYUKKTEN), '0'))::VARCHAR(2)as NYUKKTEN, --コード/区分
      IFF(rtrim(JCHUYMD) = '', '', LPAD(rtrim(JCHUYMD), length(JCHUYMD), '0'))::VARCHAR(8)as JCHUYMD, --日付
      IFF(rtrim(JCHUTIME) = '', '', LPAD(rtrim(JCHUTIME), length(JCHUTIME), '0'))::VARCHAR(4)as JCHUTIME, --時間
      rtrim(JDENNO, ' 　')::VARCHAR(6) as JDENNO, --英数字
      rtrim(CHUMON, ' 　')::VARCHAR(5) as CHUMON, --英数字
      IFF(rtrim(BOKTEN) = '', '', LPAD(rtrim(BOKTEN), length(BOKTEN), '0'))::VARCHAR(2)as BOKTEN, --コード/区分
      IFF(rtrim(SKANKTEN) = '', '', LPAD(rtrim(SKANKTEN), length(SKANKTEN), '0'))::VARCHAR(2)as SKANKTEN, --コード/区分
      IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0'))::VARCHAR(5)as USERCD, --コード/区分
      IFF(rtrim(INKTEN) = '', '', LPAD(rtrim(INKTEN), length(INKTEN), '0'))::VARCHAR(2)as INKTEN, --コード/区分
      rtrim(JCHUKBN, ' 　')::VARCHAR(1) as JCHUKBN, --英数字
      IFF(rtrim(NOUHKBN) = '', '', LPAD(rtrim(NOUHKBN), length(NOUHKBN), '0'))::VARCHAR(1)as NOUHKBN, --コード/区分
      IFF(rtrim(FLNOUHKBN) = '', '', LPAD(rtrim(FLNOUHKBN), length(FLNOUHKBN), '0'))::VARCHAR(1)as FLNOUHKBN, --コード/区分
      rtrim(JTANTOU, ' 　')::VARCHAR(5) as JTANTOU, --英数字
      rtrim(UTANTOU, ' 　')::VARCHAR(2) as UTANTOU, --英数字
      IFF(rtrim(DENK) = '', '', LPAD(rtrim(DENK), length(DENK), '0'))::VARCHAR(2)as DENK, --コード/区分
      rtrim(FLCD, ' 　')::VARCHAR(1) as FLCD, --英数字
      rtrim(REMARK1, ' 　')::VARCHAR(10) as REMARK1, --英数字
      rtrim(REMARK2, ' 　')::VARCHAR(10) as REMARK2, --英数字
      rtrim(RIYUU, ' 　')::VARCHAR(3) as RIYUU, --英数字
      IFF(rtrim(SETYMD) = '', '', LPAD(rtrim(SETYMD), length(SETYMD), '0'))::VARCHAR(8)as SETYMD, --日付
      IFF(rtrim(KASISAKIU) = '', '', LPAD(rtrim(KASISAKIU), length(KASISAKIU), '0'))::VARCHAR(5)as KASISAKIU, --コード区分
      IFF(rtrim(KASYUU) = '', '', LPAD(rtrim(KASYUU), length(KASYUU), '0'))::VARCHAR(5)as KASYUU, --コード区分
      IFF(rtrim(C80FLG) = '', '', LPAD(rtrim(C80FLG), length(C80FLG), '0'))::VARCHAR(1)as C80FLG, --フラグ
      rtrim(URIKBN, ' 　')::VARCHAR(1) as URIKBN, --英数字
      rtrim(URISFLG, ' 　')::VARCHAR(1) as URISFLG, --英数字
      IFF(rtrim(GENKACD) = '', '', LPAD(rtrim(GENKACD), length(GENKACD), '0'))::VARCHAR(1)as GENKACD, --コード/区分
      to_decimal(IFF(rtrim(PRICEKN) = '', 0,
                 concat(rtrim("PRICEKN-S", ' 　'), rtrim(PRICEKN))))::DECIMAL(7)as PRICEKN, --数量/金額/数値
      to_decimal(IFF(rtrim(NOUHBAIK) = '', 0,
                 concat(rtrim("NOUHBAIK-S", ' 　'), rtrim(NOUHBAIK))))::DECIMAL(7)as NOUHBAIK, --数量/金額/数値
      to_decimal(IFF(rtrim(TEKIBAIK) = '', 0,
                 concat(rtrim("TEKIBAIK-S", ' 　'), rtrim(TEKIBAIK))))::DECIMAL(7)as TEKIBAIK, --数量/金額/数値
      to_decimal(IFF(rtrim(PRICELP) = '', 0,
                 concat(rtrim("PRICELP-S", ' 　'), rtrim(PRICELP))))::DECIMAL(7)as PRICELP, --数量/金額/数値
      rtrim(ZANTEIKK, ' 　')::VARCHAR(1) as ZANTEIKK, --英数字
      rtrim(KCLAS, ' 　')::VARCHAR(2) as KCLAS, --英数字
      IFF(rtrim(HINSIJ) = '', '', LPAD(rtrim(HINSIJ), length(HINSIJ), '0'))::VARCHAR(1)as HINSIJ, --コード/区分
      IFF(rtrim(TANTEKI) = '', '', LPAD(rtrim(TANTEKI), length(TANTEKI), '0'))::VARCHAR(3)as TANTEKI, --コード/区分
      IFF(rtrim(SSHINMOK) = '', '', LPAD(rtrim(SSHINMOK), length(SSHINMOK), '0'))::VARCHAR(2)as SSHINMOK, --コード/区分
      rtrim(GAITOLES, ' 　')::VARCHAR(1) as GAITOLES, --英数字
      IFF(rtrim(PKANFLG) = '', '', LPAD(rtrim(PKANFLG), length(PKANFLG), '0'))::VARCHAR(1)as PKANFLG, --フラグ
      rtrim(BUNRICD, ' 　')::VARCHAR(1) as BUNRICD, --英数字
      IFF(rtrim(NYUKAYD) = '', '', LPAD(rtrim(NYUKAYD), length(NYUKAYD), '0'))::VARCHAR(8)as NYUKAYD,  --日付
      IFF(rtrim(NYUTIME) = '', '', LPAD(rtrim(NYUTIME), length(NYUTIME), '0'))::VARCHAR(4)as NYUTIME, --時間
      rtrim(NYUKAYK, ' 　')::VARCHAR(1) as NYUKAYK, --英数字
      rtrim(DAIHIN, ' 　')::VARCHAR(20) as DAIHIN, --英数字
      rtrim(DAIMKBN, ' 　')::VARCHAR(1) as DAIMKBN, --英数字
      to_decimal(IFF(rtrim(JCHUSU) = '', 0,
                 concat(rtrim("JCHUSU-S", ' 　'), rtrim(JCHUSU))))::DECIMAL(5)as JCHUSU, --数量/金額/数値
      to_decimal(IFF(rtrim(BOSU) = '', 0,
                 concat(rtrim("BOSU-S", ' 　'), rtrim(BOSU))))::DECIMAL(5)as BOSU, --数量/金額/数値
      rtrim(ZENSUFLG, ' 　')::VARCHAR(1) as ZENSUFLG, --英数字
      to_decimal(IFF(rtrim(SYUKKEI) = '', 0,
                 concat(rtrim("SYUKKEI-S", ' 　'), rtrim(SYUKKEI))))::DECIMAL(5)as SYUKKEI, --数量/金額/数値
      to_decimal(IFF(rtrim(HKYYKSU) = '', 0,
                 concat(rtrim("HKYYKSU-S", ' 　'), rtrim(HKYYKSU))))::DECIMAL(5)as HKYYKSU, --数量/金額/数値
      rtrim(SYUKKFLG, ' 　')::VARCHAR(1) as SYUKKFLG, --英数字
      to_decimal(IFF(rtrim(BOKCNT) = '', 0, rtrim(BOKCNT)))::DECIMAL(2)as BOKCNT, --数量/金額/数値
      IFF(rtrim(NDASIYMD) = '', '', LPAD(rtrim(NDASIYMD), length(NDASIYMD), '0'))::VARCHAR(8)as NDASIYMD, --日付
      IFF(rtrim(NDASITIME) = '', '', LPAD(rtrim(NDASITIME), length(NDASITIME), '0'))::VARCHAR(4)as NDASITIME, --時間
      rtrim(SYUKDENNO, ' 　')::VARCHAR(6) as SYUKDENNO, --英数字
      IFF(rtrim(SASYOTM) = '', '', LPAD(rtrim(SASYOTM), length(SASYOTM), '0'))::VARCHAR(4)as SASYOTM, --時間
      IFF(rtrim(MNTYMD) = '', '', LPAD(rtrim(MNTYMD), length(MNTYMD), '0'))::VARCHAR(8)as MNTYMD, --日付
      rtrim(DAITAIFLG, ' 　')::VARCHAR(1) as DAITAIFLG, --英数字
      rtrim(FFFLG, ' 　')::VARCHAR(1) as FFFLG, --英数字
      rtrim(PTOPFLG, ' 　')::VARCHAR(1) as PTOPFLG, --英数字
      IFF(rtrim(IDORJECT) = '', '', LPAD(rtrim(IDORJECT), length(IDORJECT), '0'))::VARCHAR(1)as IDORJECT,  --フラグ
      IFF(rtrim(ITAKUKBN) = '', '', LPAD(rtrim(ITAKUKBN), length(ITAKUKBN), '0'))::VARCHAR(1)as ITAKUKBN, --コード/区分
      IFF(rtrim(PTOPSEQ) = '', '', LPAD(rtrim(PTOPSEQ), length(PTOPSEQ), '0'))::VARCHAR(11)as PTOPSEQ, --コード/区分
      rtrim(KAKAKUSKB, ' 　')::VARCHAR(1) as KAKAKUSKB, --英数字
      rtrim(NJKBN, ' 　')::VARCHAR(1) as NJKBN, --英数字,
      LDTS, --B層のLDTS
      RANK() over(partition by KYOUHAN, HINBAN, MKBN, NYUKKTEN, CHUMON, USERCD, URISFLG, JCHUYMD order by LDTS desc) aggkey
    from {{ ref('substr_tbbofll') }}
)
select * from stg_tbbofll
where aggkey = 1