{{ config(snowflake_warehouse='DBT_WH') }}

with stg_tbnoukifl_latest as (
    select
        rtrim(kyouhan,' 　')::varchar(5) as kyouhan,  -- 英数字
        iff(rtrim(usercd) = '','',lpad(rtrim(usercd),length(usercd),'0'))::varchar(5) as usercd,  -- コード／区分
        rtrim(hinban,' 　')::varchar(20) as hinban,  -- 英数字
        rtrim(mkbn,' 　')::varchar(1) as mkbn,  -- 英数字
        iff(rtrim(jchuymd) = '','',lpad(rtrim(jchuymd),length(jchuymd),'0'))::varchar(8) as jchuymd,  -- 日付
        iff(rtrim(jchutime) = '','',lpad(rtrim(jchutime),length(jchutime),'0'))::varchar(4) as jchutime,  -- 時間
        rtrim(jdenno,' 　')::varchar(6) as jdenno,  -- 英数字
        rtrim(jdennoeda,' 　')::varchar(2) as jdennoeda,  -- 英数字
        rtrim(chumon,' 　')::varchar(5) as chumon,  -- 英数字
        iff(rtrim(nyukktn) = '','',lpad(rtrim(nyukktn),length(nyukktn),'0'))::varchar(2) as nyukktn,  -- コード／区分
        iff(rtrim(jchuktn) = '','',lpad(rtrim(jchuktn),length(jchuktn),'0'))::varchar(2) as jchuktn,  -- コード／区分
        iff(rtrim(shitei) = '','',lpad(rtrim(shitei),length(shitei),'0'))::varchar(8) as shitei,  -- 日付
        rtrim(urikbn,' 　')::varchar(1) as urikbn,  -- 英数字
        rtrim(hchuhzaikbn,' 　')::varchar(1) as hchuhzaikbn,  -- 英数字
        iff(rtrim(gsy) = '','',lpad(rtrim(gsy),length(gsy),'0'))::varchar(2) as gsy,  -- コード／区分
        rtrim(kaisya,' 　')::varchar(2) as kaisya,  -- 英数字
        rtrim(tchumon,' 　')::varchar(14) as tchumon,  -- 英数字
        rtrim(nouhkbn,' 　')::varchar(1) as nouhkbn,  -- 英数字
        rtrim(sgroup1,' 　')::varchar(2) as sgroup1,  -- 英数字
        iff(rtrim(goguchi) = '','',lpad(rtrim(goguchi),length(goguchi),'0'))::varchar(1) as goguchi,  -- コード／区分
        rtrim(rokeg,' 　')::varchar(1) as rokeg,  -- 英数字
        iff(rtrim(bunsan) = '','',lpad(rtrim(bunsan),length(bunsan),'0'))::varchar(1) as bunsan,  -- コード／区分
        rtrim(hinmok,' 　')::varchar(4) as hinmok,  -- 英数字
        rtrim(shincd,' 　')::varchar(2) as shincd,  -- 英数字
        iff(rtrim(makercd) = '','',lpad(rtrim(makercd),length(makercd),'0'))::varchar(5) as makercd,  -- コード／区分
        rtrim(kyokbn,' 　')::varchar(1) as kyokbn,  -- 英数字
        rtrim(syukkflg,' 　')::varchar(1) as syukkflg,  -- 英数字
        iff(rtrim(kanryouymd) = '','',lpad(rtrim(kanryouymd),length(kanryouymd),'0'))::varchar(8) as kanryouymd,  -- 日付
        to_decimal(iff(rtrim(kensu) = '',0,rtrim(kensu)))::decimal(2) as kensu,  -- 数量／金額／数値
        iff(rtrim(hisouktn) = '','',lpad(rtrim(hisouktn),length(hisouktn),'0'))::varchar(2) as hisouktn,  -- コード／区分
        rtrim(syakptn,' 　')::varchar(1) as syakptn,  -- 英数字
        rtrim(syakkbn,' 　')::varchar(1) as syakkbn,  -- 英数字
        rtrim(hbinno,' 　')::varchar(4) as hbinno,  -- 英数字
        iff(rtrim(syukkbn) = '','',lpad(rtrim(syukkbn),length(syukkbn),'0'))::varchar(1) as syukkbn,  -- コード／区分
        rtrim(syukktn,' 　')::varchar(2) as syukktn,  -- 英数字
        iff(rtrim(nokiymd) = '','',lpad(rtrim(nokiymd),length(nokiymd),'0'))::varchar(8) as nokiymd,  -- 日付
        rtrim(binno,' 　')::varchar(1) as binno,  -- 英数字
        iff(rtrim(hikiwatashi) = '','',lpad(rtrim(hikiwatashi),length(hikiwatashi),'0'))::varchar(4) as hikiwatashi,  -- 時間
        iff(rtrim(kaitymd) = '','',lpad(rtrim(kaitymd),length(kaitymd),'0'))::varchar(8) as kaitymd,  -- 日付
        iff(rtrim(kaittime) = '','',lpad(rtrim(kaittime),length(kaittime),'0'))::varchar(4) as kaittime,  -- 時間
        rtrim(nokikbn,' 　')::varchar(1) as nokikbn,  -- 英数字
        iff(rtrim(hknyukaymd) = '','',lpad(rtrim(hknyukaymd),length(hknyukaymd),'0'))::varchar(8) as hknyukaymd,  -- 日付
        iff(rtrim(hknyukatime) = '','',lpad(rtrim(hknyukatime),length(hknyukatime),'0'))::varchar(4) as hknyukatime,  -- 時間
        iff(rtrim(hkkanymd) = '','',lpad(rtrim(hkkanymd),length(hkkanymd),'0'))::varchar(8) as hkkanymd,  -- 日付
        iff(rtrim(hkkantime) = '','',lpad(rtrim(hkkantime),length(hkkantime),'0'))::varchar(4) as hkkantime,  -- 時間
        iff(rtrim(syukknoymd) = '','',lpad(rtrim(syukknoymd),length(syukknoymd),'0'))::varchar(8) as syukknoymd,  -- 日付
        iff(rtrim(syukknotime) = '','',lpad(rtrim(syukknotime),length(syukknotime),'0'))::varchar(4) as syukknotime,  -- 時間
        rtrim(keitai,' 　')::varchar(1) as keitai,  -- 英数字
        iff(rtrim(defkaito) = '','',lpad(rtrim(defkaito),length(defkaito),'0'))::varchar(1) as defkaito,  -- フラグ
        iff(rtrim(msyukaymd) = '','',lpad(rtrim(msyukaymd),length(msyukaymd),'0'))::varchar(8) as msyukaymd,  -- 日付
        iff(rtrim(msyukatime) = '','',lpad(rtrim(msyukatime),length(msyukatime),'0'))::varchar(4) as msyukatime,  -- 時間
        ldts, -- b層のldts
        rank() over (
                partition by
                    kyouhan, hinban, mkbn, jchuymd, jchutime, jdenno, jdennoeda
                order by kensu desc, ldts desc
            ) aggkey
        from {{ ref('substr_tbnoukifl') }}
        where nokikbn <= '6'
    )
select *
from stg_tbnoukifl_latest
where aggkey = 1