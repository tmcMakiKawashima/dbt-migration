with stg_dvsf509a as (
    select
        rtrim(TYOTATHB,' 　')::VARCHAR(20) as TYOTATHB,  -- 英数字
        rtrim(KAKNOUKBN,' 　')::VARCHAR(1) as KAKNOUKBN,  -- 英数字
        rtrim(SRSIRSKCD,' 　')::VARCHAR(4) as SRSIRSKCD,  -- 英数字
        rtrim(HINBANKAISIYMD,' 　')::VARCHAR(8) as HINBANKAISIYMD,  -- 英数字
        rtrim(HINBANSRYOYMD,' 　')::VARCHAR(8) as HINBANSRYOYMD,  -- 英数字
        rtrim(TEHAIKAISIYMD,' 　')::VARCHAR(8) as TEHAIKAISIYMD,  -- 英数字
        rtrim(TEHAISRYOYMD,' 　')::VARCHAR(8) as TEHAISRYOYMD,  -- 英数字
        rtrim(MOTIKOMISK,' 　')::VARCHAR(4) as MOTIKOMISK,  -- 英数字
        rtrim(KOTEIKBN,' 　')::VARCHAR(1) as KOTEIKBN,  -- 英数字
        rtrim(BRSIRSKCD,' 　')::VARCHAR(4) as BRSIRSKCD,  -- 英数字
        rtrim(THIBUSYOCD,' 　')::VARCHAR(5) as THIBUSYOCD,  -- 英数字
        rtrim(THITATOCD,' 　')::VARCHAR(2) as THITATOCD,  -- 英数字
        rtrim(TEHAIKBN,' 　')::VARCHAR(1) as TEHAIKBN,  -- 英数字
        rtrim(ZAIHIKBN,' 　')::VARCHAR(1) as ZAIHIKBN,  -- 英数字
        rtrim(KANBNKBN,' 　')::VARCHAR(1) as KANBNKBN,  -- 英数字
        rtrim(CYCLE4,' 　')::VARCHAR(4) as CYCLE4,  -- 英数字
        rtrim(HATYUKAISU,' 　')::VARCHAR(1) as HATYUKAISU,  -- 英数字
        rtrim(BINSITEITAIO1,' 　')::VARCHAR(1) as BINSITEITAIO1,  -- 英数字
        rtrim(BINSITEITAIO2,' 　')::VARCHAR(1) as BINSITEITAIO2,  -- 英数字
        rtrim(BINSITEITAIO3,' 　')::VARCHAR(1) as BINSITEITAIO3,  -- 英数字
        rtrim(KOTEIMAISUMAISU,' 　')::VARCHAR(3) as KOTEIMAISUMAISU,  -- 英数字
        rtrim(KOTEIMAISHNKYM,' 　')::VARCHAR(6) as KOTEIMAISHNKYM,  -- 英数字
        rtrim(KJNZIKNISU3,' 　')::VARCHAR(3) as KJNZIKNISU3,  -- 英数字
        rtrim(KJNZIKSU,' 　')::VARCHAR(7) as KJNZIKSU,  -- 英数字
        rtrim(ANZENZAIKONISU,' 　')::VARCHAR(3) as ANZENZAIKONISU,  -- 英数字
        rtrim(ANZNZKSU,' 　')::VARCHAR(7) as ANZNZKSU,  -- 英数字
        rtrim(KOTYRYDHJOGNRIT,' 　')::VARCHAR(3) as KOTYRYDHJOGNRIT,  -- 英数字
        rtrim(KOTYRYDHKAGNRIT,' 　')::VARCHAR(3) as KOTYRYDHKAGNRIT,  -- 英数字
        rtrim(KYOTEIJOGNMAISU,' 　')::VARCHAR(3) as KYOTEIJOGNMAISU,  -- 英数字
        rtrim(MIKKABARASIUM,' 　')::VARCHAR(1) as MIKKABARASIUM,  -- 英数字
        rtrim(SEBANGOU,' 　')::VARCHAR(6) as SEBANGOU,  -- 英数字
        rtrim(KNBNZDAWSTYSKBN,' 　')::VARCHAR(1) as KNBNZDAWSTYSKBN,  -- 英数字
        rtrim(NONYULT,' 　')::VARCHAR(2) as NONYULT,  -- 英数字
        rtrim(HAKKOCYCLE,' 　')::VARCHAR(2) as HAKKOCYCLE,  -- 英数字
        rtrim(ZAIKOITTEISU,' 　')::VARCHAR(7) as ZAIKOITTEISU,  -- 英数字
        rtrim(NONUKYOKBN,' 　')::VARCHAR(1) as NONUKYOKBN,  -- 英数字
        rtrim(NBSCD,' 　')::VARCHAR(2) as NBSCD,  -- 英数字
        rtrim(UKEIRECD,' 　')::VARCHAR(2) as UKEIRECD,  -- 英数字
        rtrim(OROSIBACD,' 　')::VARCHAR(2) as OROSIBACD,  -- 英数字
        rtrim(HASUSYORIUM,' 　')::VARCHAR(1) as HASUSYORIUM,  -- 英数字
        rtrim(NONYUKGCD,' 　')::VARCHAR(5) as NONYUKGCD,  -- 英数字
        rtrim(NONYUTNI,' 　')::VARCHAR(5) as NONYUTNI,  -- 英数字
        rtrim(KUKURITYPE,' 　')::VARCHAR(1) as KUKURITYPE,  -- 英数字
        rtrim(KUKURITNI,' 　')::VARCHAR(5) as KUKURITNI,  -- 英数字
        rtrim(KENSAKBN,' 　')::VARCHAR(1) as KENSAKBN,  -- 英数字
        rtrim(SRSIRSKKOJOCD,' 　')::VARCHAR(1) as SRSIRSKKOJOCD,  -- 英数字
        rtrim(BRSIRSKKOJOCD,' 　')::VARCHAR(1) as BRSIRSKKOJOCD,  -- 英数字
        rtrim(SIRSKSYUKZYOCD,' 　')::VARCHAR(3) as SIRSKSYUKZYOCD,  -- 英数字
        rtrim(TEKIYOKAISIYMD,' 　')::VARCHAR(8) as TEKIYOKAISIYMD,  -- 英数字
        rtrim(TEKIYOSYURYOYMD,' 　')::VARCHAR(8) as TEKIYOSYURYOYMD,  -- 英数字
        rtrim(MTUSERID,' 　')::VARCHAR(16) as MTUSERID,  -- 英数字
        IFF(rtrim(MTTIME) = '','',LPAD(rtrim(MTTIME),length(MTTIME),'0'))::VARCHAR(26) as MTTIME,  -- 時間
        LDTS -- B層のLDTS
    from {{ ref('substr_dvsf509a') }}
)
select * from stg_dvsf509a
where LDTS = (select max(LDTS) from stg_dvsf509a)