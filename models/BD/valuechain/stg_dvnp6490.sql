with stg_dvnp6490 as (
    select
        rtrim(MNTKBN,' 　')::VARCHAR(1) as MNTKBN,  --英数字
        rtrim(ORDRKEY,' 　')::VARCHAR(11) as ORDRKEY,  --英数字
        rtrim(JURRSYMD,' 　')::VARCHAR(8) as JURRSYMD,  --英数字
        rtrim(TANSKKEY)::VARCHAR(11) as TANSKKEY,  --英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  --英数字
        rtrim(DLRCD,' 　')::VARCHAR(7) as DLRCD,  --英数字
        rtrim(ODRNO,' 　')::VARCHAR(8) as ODRNO,  --英数字
        rtrim(ITEMNO,' 　')::VARCHAR(4) as ITEMNO,  --英数字
        rtrim(ORDESYBT,' 　')::VARCHAR(2) as ORDESYBT,  --英数字
        rtrim(ORDRTYPE,' 　')::VARCHAR(1) as ORDRTYPE,  --英数字
        rtrim(ORDTSYRI,' 　')::VARCHAR(1) as ORDTSYRI,  --英数字
        rtrim(KNKYUDO,' 　')::VARCHAR(1) as KNKYUDO,  --英数字
        rtrim(ODRZOK,' 　')::VARCHAR(1) as ODRZOK,  --英数字
        rtrim(YUSOKBN,' 　')::VARCHAR(1) as YUSOKBN,  --英数字
        to_decimal(IFF(rtrim(BOSU) = '',0,rtrim(BOSU)))::DECIMAL(6) as BOSU,  --数量/金額/数値
        to_decimal(IFF(rtrim(JUCHUSU) = '',0,rtrim(JUCHUSU)))::DECIMAL(6) as JUCHUSU,  --数量/金額/数値
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  --英数字
        rtrim(RIMARK10,' 　')::VARCHAR(10) as RIMARK10,  --英数字
        rtrim(JHINBAN,' 　')::VARCHAR(20) as JHINBAN,  --英数字
        rtrim(ENDSIJYMD,' 　')::VARCHAR(8) as ENDSIJYMD,  --英数字
        rtrim(KYOSEICD,' 　')::VARCHAR(1) as KYOSEICD,  --英数字
        rtrim(PTOPFLG,' 　')::VARCHAR(1) as PTOPFLG,  --英数字
        rtrim(KAKNOUKBN,' 　')::VARCHAR(1) as KAKNOUKBN,  --英数字
        to_decimal(IFF(rtrim(BORUISUU9) = '',0,rtrim(BORUISUU9)))::DECIMAL(9) as BORUISUU9,  --数量/金額/数値
        rtrim(SIIRECD,' 　')::VARCHAR(4) as SIIRECD,  --英数字
        rtrim(KOTEIKBN,' 　')::VARCHAR(1) as KOTEIKBN,  --英数字
        rtrim(TANTOBUCD,' 　'):VARCHAR(5) as TANTOBUCD,  --英数字
        rtrim(TANTOCD2,' 　')::VARCHAR(2) as TANTOCD2,  --英数字
        rtrim(SEISANNAIKBN,' 　')::VARCHAR(1) as SEISANNAIKBN,  --英数字
        rtrim(ZIKHAKBN,' 　')::VARCHAR(1) as ZIKHAKBN,  --英数字
        rtrim(KANBNKBN,' 　')::VARCHAR(1) as KANBNKBN,  --英数字
        rtrim(GKKBN,' 　')::VARCHAR(1) as GKKBN,  --英数字
        rtrim(GKUBNKKYM,' 　')::VARCHAR(6) as GKUBNKKYM,  --英数字
        rtrim(KOZYOCD,' 　')::VARCHAR(1) as KOZYOCD,  --英数字
        rtrim(NONUKYOKBN,' 　')::VARCHAR(1) as NONUKYOKBN,  --英数字
        rtrim(HOSOKYTNKBN,' 　')::VARCHAR(2) as HOSOKYTNKBN,  --英数字
        rtrim(NONYULT,' 　')::VARCHAR(2) as NONYULT,  --英数字
        rtrim(BUTURYULT,' 　')::VARCHAR(2) as BUTURYULT,  --英数字
        rtrim(CYCLE4,' 　')::VARCHAR(4) as CYCLE4,  --英数字
        rtrim(HATTYUTYUSIKBN,' 　')::VARCHAR(1) as HATTYUTYUSIKBN,  --英数字
        rtrim(NONYUTNI,' 　')::VARCHAR(5) as NONYUTNI,  --英数字
        rtrim(KAITOUKBN,' 　')::VARCHAR(1) as KAITOUKBN,  --英数字
        rtrim(NYOTEIBIN,' 　')::VARCHAR(3) as NYOTEIBIN,  --英数字
        rtrim(NYOTEITIME,' 　')::VARCHAR(12) as NYOTEITIME,  --英数字
        rtrim(TNYTIME,' 　')::VARCHAR(12) as TNYTIME,  --英数字
        rtrim(SYYTIME,' 　')::VARCHAR(12) as SYYTIME,  --英数字
        rtrim(TOYTIME,' 　')::VARCHAR(12) as TOYTIME,  --英数字
        rtrim(INVYMD,' 　')::VARCHAR(8) as INVYMD,  --英数字
        rtrim(BOSKSTIME,' 　')::VARCHAR(12) as BOSKSTIME,  --英数字
        rtrim(KOKAGKBN,' 　')::VARCHAR(1) as KOKAGKBN,  --英数字
        rtrim(SYUKKODOMEFLG,' 　')::VARCHAR(1) as SYUKKODOMEFLG,  --英数字
        rtrim(DAITITYP,' 　')::VARCHAR(2) as DAITITYP,  --英数字
        rtrim(BOCD,' 　')::VARCHAR(1) as BOCD,  --英数字
        rtrim(DOITUSIMUKECD,' 　')::VARCHAR(7) as DOITUSIMUKECD,  --英数字
        rtrim(BNKTSYUKAHUKA,' 　')::VARCHAR(1) as BNKTSYUKAHUKA,  --英数字
        rtrim(DLRMEI,' 　')::VARCHAR(20) as DLRMEI,  --英数字
        rtrim(YUMUKBN,' 　')::VARCHAR(1) as YUMUKBN,  --英数字
        rtrim(HYOFTNBS,' 　')::VARCHAR(1) as HYOFTNBS,  --英数字
        rtrim(HANBAICD,' 　'):VARCHAR(1) as HANBAICD,  --英数字
        rtrim(SPDISCOUNT,' 　')::VARCHAR(4) as SPDISCOUNT,  --英数字
        rtrim(TUIKAKBN,' 　')::VARCHAR(1) as TUIKAKBN,  --英数字
        rtrim(KKKSRKBN,' 　')::VARCHAR(1) as KKKSRKBN,  --英数字
        rtrim(SAGYOKGNYMD,' 　')::VARCHAR(8) as SAGYOKGNYMD,  --英数字
        rtrim(BETMKCD,' 　')::VARCHAR(4) as BETMKCD,  --英数字
        rtrim(PFCD,' 　')::VARCHAR(2) as PFCD,  --英数字
        rtrim(INVHKTKA,' 　')::VARCHAR(1) as INVHKTKA,  --英数字
        rtrim(TKYTANIV,' 　')::VARCHAR(11) as TKYTANIV,  --英数字
        rtrim(ERRFLG,' 　')::VARCHAR(1) as ERRFLG,  --英数字
        rtrim(TATNKBN,' 　')::VARCHAR(1) as TATNKBN,  --英数字
        to_decimal(IFF(rtrim(SAGYONIS) = '',0,rtrim(SAGYONIS)))::DECIMAL(2) as SAGYONIS,  --数量/金額/数値
        to_decimal(IFF(rtrim(ZSANIS) = '',0,rtrim(ZSANIS)))::DECIMAL(2) as ZSANIS,  --数量/金額/数値
        rtrim(SYORIYMD,' 　')::VARCHAR(8) as SYORIYMD,  --英数字
        rtrim(MKAITOCD,' 　')::VARCHAR(1) as MKAITOCD,  --英数字
        rtrim(MARTFLG,' 　')::VARCHAR(1) as MARTFLG,  --英数字
        rtrim(BOKAISYOFLG,' 　')::VARCHAR(1) as BOKAISYOFLG,  --英数字
        rtrim(SAIYOFLG,' 　')::VARCHAR(1) as SAIYOFLG,  --英数字
        to_decimal(IFF(rtrim(NOKHNKCT) = '',0,rtrim(NOKHNKCT)))::VARCHAR(3) as NOKHNKCT,  --数量/金額/数値
        rtrim(KAITOLT,' 　')::VARCHAR(3) as KAITOLT,  --英数字
        to_decimal(IFF(rtrim(NOKHNKNSSA) = '',0,rtrim(NOKHNKNSSA)))::DECIMAL(4) as NOKHNKNSSA,  --数量/金額/数値
        to_decimal(IFF(rtrim(SSKZNSNSSA) = '',0,rtrim(SSKZNSNSSA)))::DECIMAL(4) as SSKZNSNSSA,  --数量/金額/数値
        to_decimal(IFF(rtrim(HSKZNSNSSA) = '',0,rtrim(HSKZNSNSSA)))::DECIMAL(4) as HSKZNSNSSA,  --数量/金額/数値
        rtrim(HNKKBN,' 　')::VARCHAR(1) as HNKKBN,  --英数字
        rtrim(HNNOYTIME,' 　')::VARCHAR(12) as HNNOYTIME,  --英数字
        rtrim(HNTAYTIME,' 　')::VARCHAR(12) as HNTAYTIME,  --英数字
        rtrim(HNSYYTIME,' 　')::VARCHAR(12) as HNSYYTIME,  --英数字
        rtrim(HNTOYTIME,' 　')::VARCHAR(12) as HNTOYTIME,  --英数字
        rtrim(HNKAITOYMD,' 　')::VARCHAR(8) as HNKAITOYMD,  --絵数字
        rtrim(ENKKBN,' 　')::VARCHAR(1) as ENKKBN,  --英数字
        rtrim(HNETD,' 　')::VARCHAR(8) as HNETD,  --英数字
        rtrim(ENKTOYMD,' 　')::VARCHAR(8) as ENKTOYMD,  --英数字
        rtrim(HOKAITOUKBN,' 　')::VARCHAR(1) as HOKAITOUKBN,  --英数字
        rtrim(HONOYTIME,' 　')::VARCHAR(12) as HONOYTIME,  --英数字
        rtrim(HOTAYTIME,' 　')::VARCHAR(12) as HOTAYTIME,  --英数字
        rtrim(HOSYYTIME,' 　')::VARCHAR(12) as HOSYYTIME,  --英数字
        rtrim(HOTOYTIME,' 　')::VARCHAR(12) as HOTOYTIME,  --英数字
        rtrim(HOKAITOYMD,' 　')::VARCHAR(8) as HOKAITOYMD,  --英数字
        rtrim(EOKKBN,' 　')::VARCHAR(1) as EOKKBN,  --英数字
        rtrim(EOFYTYMD,' 　')::VARCHAR(8) as EOFYTYMD,  --英数字
        rtrim(EOKTOYMD,' 　')::VARCHAR(8) as EOKTOYMD,  --英数字
        rtrim(HOKAITOUKBNM2,' 　')::VARCHAR(1) as HOKAITOUKBNM2,  --英数字
        rtrim(HONOYTIMEM2,' 　')::VARCHAR(12) as HONOYTIMEM2,  --英数字
        rtrim(HOTAYTIMEM2,' 　')::VARCHAR(12) as HOTAYTIMEM2,  --英数字
        rtrim(HOSYYTIMEM2,' 　')::VARCHAR(12) as HOSYYTIMEM2,  --英数字
        rtrim(HOTOYTIMEM2,' 　')::VARCHAR(12) as HOTOYTIMEM2,  --英数字
        rtrim(HOKAITOYMDM2,' 　')::VARCHAR(8) as HOKAITOYMDM2,  --英数字
        rtrim(EOKKBNM2,' 　')::VARCHAR(1) as EOKKBNM2,  --英数字
        rtrim(EOFYTYMDM2,' 　')::VARCHAR(8) as EOFYTYMDM2,  --英数字
        rtrim(EOKTOYMDM2,' 　')::VARCHAR(8) as EOKTOYMDM2,  --英数字
        rtrim(HOKAITOUKBNM3,' 　')::VARCHAR(1) as HOKAITOUKBNM3,  --英数字
        rtrim(HONOYTIMEM3,' 　')::VARCHAR(12) as HONOYTIMEM3,  --英数字
        rtrim(HOTAYTIMEM3,' 　')::VARCHAR(12) as HOTAYTIMEM3,  --英数字
        rtrim(HOSYYTIMEM3,' 　')::VARCHAR(12) as HOSYYTIMEM3,  --英数字
        rtrim(HOTOYTIMEM3,' 　')::VARCHAR(12) as HOTOYTIMEM3,  --英数字
        rtrim(HOKAITOYMDM3,' 　')::VARCHAR(8) as HOKAITOYMDM3,  --英数字
        rtrim(EOKKBNM3,' 　')::VARCHAR(1) as EOKKBNM3,  --英数字
        rtrim(EOFYTYMDM3,' 　')::VARCHAR(8) as EOFYTYMDM3,  --英数字
        rtrim(EOKTOYMDM3,' 　')::VARCHAR(8) as EOKTOYMDM3,  --英数字
        rtrim(HSKAITOUKBN,' 　')::VARCHAR(1) as HSKAITOUKBN,  --英数字
        rtrim(HSNOYTIME,' 　')::VARCHAR(12) as HSNOYTIME,  --英数字
        rtrim(HSTAYTIME,' 　')::VARCHAR(12) as HSTAYTIME,  --英数字
        rtrim(HSSYYTIME,' 　')::VARCHAR(12) as HSSYYTIME,  --英数字
        rtrim(HSTOYTIME,' 　')::VARCHAR(12) as HSTOYTIME,  --英数字
        rtrim(HSKAITOYMD,' 　')::VARCHAR(8) as HSKAITOYMD,  --英数字
        rtrim(ESKKBN,' 　')::VARCHAR(1) as ESKKBN,  --英数字
        rtrim(HSETD,' 　')::VARCHAR(8) as HSETD,  --英数字
        rtrim(ESKTOYMD,' 　')::VARCHAR(8) as ESKTOYMD,  --英数字
        rtrim(ETDSAIYOFLG,' 　')::VARCHAR(1) as ETDSAIYOFLG,  --英数字
        rtrim(ETDHENKOCNT,' 　')::VARCHAR(3) as ETDHENKOCNT,  --英数字
        rtrim(ETDKAITLT,' 　')::VARCHAR(3) as ETDKAITLT,  --英数字
        to_decimal(IFF(rtrim(ETDHNKNSSA) = '',0,rtrim(ETDHNKNSSA)))::DECIMAL(4) as ETDHNKNSSA,  --数量/金額/数値
        to_decimal(IFF(rtrim(ETDSSKZNSNSSA) = '',0,rtrim(ETDSSKZNSNSSA)))::DECIMAL(4) as ETDSSKZNSNSSA,  --数量/金額/数値
        to_decimal(IFF(rtrim(ETDHSKZNSNSSA) = '',0,rtrim(ETDHSKZNSNSSA)))::DECIMAL(4) as ETDHSKZNSNSSA,  --数量/金額/数値
        rtrim(SKJUNI,' 　')::VARCHAR(6) as SKJUNI,  --英数字
        rtrim(IPSYYTMIE,' 　')::VARCHAR(12) as IPSYYTMIE,  --英数字
        rtrim(IPFYTYMD,' 　')::VARCHAR(8) as IPFYTYMD,  --英数字
        rtrim(OG,' 　')::VARCHAR(2) as OG,  --英数字
        rtrim(CRSNZKBN,' 　')::VARCHAR(1) as CRSNZKBN,  --英数字
        rtrim(CASENO,' 　')::VARCHAR(8) as CASENO,  --英数字
        rtrim(SKZUMTIME,' 　')::VARCHAR(12) as SKZUMTIME,  --英数字
        rtrim(ZITUETD)::VARCHAR(8) as ZITUETD,  --英数字
        rtrim(BONOKIKANLSTZFLG,' 　')::VARCHAR(1) as BONOKIKANLSTZFLG,  --英数字
        rtrim(KONPOAIR,' 　')::VARCHAR(1) as KONPOAIR,  --英数字
        rtrim(KONPOSEA,' 　')::VARCHAR(1) as KONPOSEA,  --英数字
        rtrim(BNGSIJ,' 　')::VARCHAR(1) as BNGSIJ,  --英数字
        rtrim(TIIKICD2,' 　')::VARCHAR(2) as TIIKICD2,  --英数字
        rtrim(TEHAIKBN,' 　')::VARCHAR(1) as TEHAIKBN,  --英数字
        rtrim(NOKIBRFLG,' 　')::VARCHAR(1) as NOKIBRFLG,  --英数字
        rtrim(KNISYOHINCD,' 　')::VARCHAR(2) as KNISYOHINCD,  --英数字
        rtrim(HINMKCD,' 　')::VARCHAR(4) as HINMKCD,  --英数字
        rtrim(GKKBNG,' 　')::VARCHAR(1) as GKKBNG,  --英数字
        rtrim(ENDKI4,' 　')::VARCHAR(4) as ENDKI4,  --英数字
        to_decimal(IFF(rtrim(JCJSK7KNIGKNM1F) = '',0,rtrim(JCJSK7KNIGKNM1F)))::DECIMAL(8) as JCJSK7KNIGKNM1F,  --数量/金額/数値
        to_decimal(IFF(rtrim(JCJSK7KNIGKNM2F) = '',0,rtrim(JCJSK7KNIGKNM2F)))::DECIMAL(8) as JCJSK7KNIGKNM2F,  --数量/金額/数値
        to_decimal(IFF(rtrim(JCJSK7KNIGKNM3F) = '',0,rtrim(JCJSK7KNIGKNM3F)))::DECIMAL(8) as JCJSK7KNIGKNM3F,  --数量/金額/数値
        to_decimal(IFF(rtrim(KGIHIRITUF) = '',0,rtrim(KGIHIRITUF)))::DECIMAL(4) as KGIHIRITUF,  --数量/金額/数値
        rtrim(FILLER,' 　')::VARCHAR(5) as FILLER,  --英数字
        rtrim(HKANRI,' 　')::VARCHAR(4) as HKANRI,  --英数字
        rtrim(FILLER2,' 　')::VARCHAR(5) as FILLER2,  --英数字
        LDTS,  --B層のLDTS
        RANK() over (partition by ORDRKEY, JURRSYMD, TANSKKEY order by LDTS) aggkey
    from {{ ref('substr_dvnp6490') }}
)
select * from stg_dvnp6490
where aggkey = 1