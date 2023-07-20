with stg_dvnp0680 as (
    select
        rtrim(ORDRKEY,' 　')::VARCHAR(11) as ORDRKEY,  -- 英数字
        rtrim(KOKAGKBN,' 　')::VARCHAR(1) as KOKAGKBN,  -- 英数字
        rtrim(DATAKBN4,' 　')::VARCHAR(4) as DATAKBN4,  -- 英数字
        rtrim(DLRCD,' 　')::VARCHAR(7) as DLRCD,  -- 英数字
        rtrim(YUSOKBN,' 　')::VARCHAR(1) as YUSOKBN,  -- 英数字
        rtrim(ODRNO,' 　')::VARCHAR(8) as ODRNO,  -- 英数字
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  -- 英数字
        rtrim(ITEMNO,' 　')::VARCHAR(4) as ITEMNO,  -- 英数字
        rtrim(JHINBAN,' 　')::VARCHAR(20) as JHINBAN,  -- 英数字
        rtrim(SYUBETSU,' 　')::VARCHAR(2) as SYUBETSU,  -- 英数字
        rtrim(ORDRTYPE,' 　')::VARCHAR(1) as ORDRTYPE,  -- 英数字
        rtrim(ORDTSYRI,' 　')::VARCHAR(1) as ORDTSYRI,  -- 英数字
        rtrim(KNKYUDO1,' 　')::VARCHAR(1) as KNKYUDO1,  -- 英数字
        rtrim(ODRZOK,' 　')::VARCHAR(1) as ODRZOK,  -- 英数字
        rtrim(YUMUKBN,' 　')::VARCHAR(1) as YUMUKBN,  -- 英数字
        rtrim(HYOFTNBS,' 　')::VARCHAR(1) as HYOFTNBS,  -- 英数字
        rtrim(KYOSEICD,' 　')::VARCHAR(1) as KYOSEICD,  -- 英数字
        rtrim(HANBAICD,' 　')::VARCHAR(1) as HANBAICD,  -- 英数字
        rtrim(BOCD,' 　')::VARCHAR(1) as BOCD,  -- 英数字
        rtrim(YUSOUTCD,' 　')::VARCHAR(1) as YUSOUTCD,  -- 英数字
        rtrim(SPDISCOUNT,' 　')::VARCHAR(4) as SPDISCOUNT,  -- 英数字
        rtrim(TUIKAKBN,' 　')::VARCHAR(1) as TUIKAKBN,  -- 英数字
        rtrim(KKKSRKBN,' 　')::VARCHAR(1) as KKKSRKBN,  -- 英数字
        rtrim(SAGYOKGNYMD,' 　')::VARCHAR(8) as SAGYOKGNYMD,  -- 英数字
        rtrim(ZUIZIKBN,' 　')::VARCHAR(1) as ZUIZIKBN,  -- 英数字
        rtrim(ZUIZIRTU,' 　')::VARCHAR(3) as ZUIZIRTU,  -- 英数字
        rtrim(BETMKCD,' 　')::VARCHAR(4) as BETMKCD,  -- 英数字
        rtrim(JYUSYYMD,' 　')::VARCHAR(8) as JYUSYYMD,  -- 英数字
        to_decimal(IFF(rtrim(JUCHUSU) = '',0,rtrim(JUCHUSU)))::DECIMAL(6) as JUCHUSU,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(PROJUSUU6) = '',0,rtrim(PROJUSUU6)))::DECIMAL(6) as PROJUSUU6,  -- 数量／金額／数値
        rtrim(TARIFCD,' 　')::VARCHAR(3) as TARIFCD,  -- 英数字
        rtrim(TOKTANKA9,' 　')::VARCHAR(9) as TOKTANKA9,  -- 英数字
        rtrim(TANSJYMD,' 　')::VARCHAR(8) as TANSJYMD,  -- 英数字
        rtrim(RIMAK1,' 　')::VARCHAR(10) as RIMAK1,  -- 英数字
        rtrim(RIMAK2,' 　')::VARCHAR(1) as RIMAK2,  -- 英数字
        rtrim(BNRKYSCD,' 　')::VARCHAR(1) as BNRKYSCD,  -- 英数字
        rtrim(BEKONCD,' 　')::VARCHAR(1) as BEKONCD,  -- 英数字
        rtrim(SIMKMEIK,' 　')::VARCHAR(20) as SIMKMEIK,  -- 英数字
        rtrim(SIMKMEIJP,' 　')::VARCHAR(3) as SIMKMEIJP,  -- 英数字
        rtrim(YUSTGTCD,' 　')::VARCHAR(8) as YUSTGTCD,  -- 英数字
        rtrim(ORDRCYCL,' 　')::VARCHAR(1) as ORDRCYCL,  -- 英数字
        rtrim(SDLRCD,' 　')::VARCHAR(7) as SDLRCD,  -- 英数字
        rtrim(PSHUKAKBN,' 　')::VARCHAR(1) as PSHUKAKBN,  -- 英数字
        rtrim(DOUKNHUKAKBN,' 　')::VARCHAR(1) as DOUKNHUKAKBN,  -- 英数字
        rtrim(SYTYUBANFLG,' 　')::VARCHAR(1) as SYTYUBANFLG,  -- 英数字
        rtrim(TANDKBAN,' 　')::VARCHAR(1) as TANDKBAN,  -- 英数字
        rtrim(KNPKTCD,' 　')::VARCHAR(1) as KNPKTCD,  -- 英数字
        rtrim(HANSTSAKCD,' 　')::VARCHAR(3) as HANSTSAKCD,  -- 英数字
        rtrim(ETCTES,' 　')::VARCHAR(3) as ETCTES,  -- 英数字
        rtrim(KESSAI,' 　')::VARCHAR(2) as KESSAI,  -- 英数字
        rtrim(TATNKBN,' 　')::VARCHAR(1) as TATNKBN,  -- 英数字
        rtrim(TNDKINV,' 　')::VARCHAR(1) as TNDKINV,  -- 英数字
        rtrim(TARIFDKN,' 　')::VARCHAR(1) as TARIFDKN,  -- 英数字
        rtrim(PFCD,' 　')::VARCHAR(2) as PFCD,  -- 英数字
        rtrim(MTUSERID,' 　')::VARCHAR(16) as MTUSERID,  -- 英数字
        rtrim(MTTIME,' 　')::VARCHAR(26) as MTTIME,  -- 英数字
        rtrim(FILLER,' 　')::VARCHAR(45) as FILLER,  -- 英数字
        LDTS, -- B層のLDTS
        RANK() over (partition by ORDRKEY, JUCHUYMD order by MTTIME desc, LDTS desc) aggkey
    from {{ ref('substr_dvnp0680') }}
)
select * from stg_dvnp0680
where aggkey = 1