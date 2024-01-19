with stg_dvsf509a as (
    select
        rtrim(tyotathb,' 　')::varchar(20) as tyotathb,  -- 英数字
        rtrim(kaknoukbn,' 　')::varchar(1) as kaknoukbn,  -- 英数字
        rtrim(srsirskcd,' 　')::varchar(4) as srsirskcd,  -- 英数字
        rtrim(hinbankaisiymd,' 　')::varchar(8) as hinbankaisiymd,  -- 英数字
        rtrim(hinbansryoymd,' 　')::varchar(8) as hinbansryoymd,  -- 英数字
        rtrim(tehaikaisiymd,' 　')::varchar(8) as tehaikaisiymd,  -- 英数字
        rtrim(tehaisryoymd,' 　')::varchar(8) as tehaisryoymd,  -- 英数字
        rtrim(motikomisk,' 　')::varchar(4) as motikomisk,  -- 英数字
        rtrim(koteikbn,' 　')::varchar(1) as koteikbn,  -- 英数字
        rtrim(brsirskcd,' 　')::varchar(4) as brsirskcd,  -- 英数字
        rtrim(thibusyocd,' 　')::varchar(5) as thibusyocd,  -- 英数字
        rtrim(thitatocd,' 　')::varchar(2) as thitatocd,  -- 英数字
        rtrim(tehaikbn,' 　')::varchar(1) as tehaikbn,  -- 英数字
        rtrim(zaihikbn,' 　')::varchar(1) as zaihikbn,  -- 英数字
        rtrim(kanbnkbn,' 　')::varchar(1) as kanbnkbn,  -- 英数字
        rtrim(cycle4,' 　')::varchar(4) as cycle4,  -- 英数字
        rtrim(hatyukaisu,' 　')::varchar(1) as hatyukaisu,  -- 英数字
        rtrim(binsiteitaio1,' 　')::varchar(1) as binsiteitaio1,  -- 英数字
        rtrim(binsiteitaio2,' 　')::varchar(1) as binsiteitaio2,  -- 英数字
        rtrim(binsiteitaio3,' 　')::varchar(1) as binsiteitaio3,  -- 英数字
        rtrim(koteimaisumaisu,' 　')::varchar(3) as koteimaisumaisu,  -- 英数字
        rtrim(koteimaishnkym,' 　')::varchar(6) as koteimaishnkym,  -- 英数字
        rtrim(kjnziknisu3,' 　')::varchar(3) as kjnziknisu3,  -- 英数字
        rtrim(kjnziksu,' 　')::varchar(7) as kjnziksu,  -- 英数字
        rtrim(anzenzaikonisu,' 　')::varchar(3) as anzenzaikonisu,  -- 英数字
        rtrim(anznzksu,' 　')::varchar(7) as anznzksu,  -- 英数字
        rtrim(kotyrydhjognrit,' 　')::varchar(3) as kotyrydhjognrit,  -- 英数字
        rtrim(kotyrydhkagnrit,' 　')::varchar(3) as kotyrydhkagnrit,  -- 英数字
        rtrim(kyoteijognmaisu,' 　')::varchar(3) as kyoteijognmaisu,  -- 英数字
        rtrim(mikkabarasium,' 　')::varchar(1) as mikkabarasium,  -- 英数字
        rtrim(sebangou,' 　')::varchar(6) as sebangou,  -- 英数字
        rtrim(knbnzdawstyskbn,' 　')::varchar(1) as knbnzdawstyskbn,  -- 英数字
        rtrim(nonyult,' 　')::varchar(2) as nonyult,  -- 英数字
        rtrim(hakkocycle,' 　')::varchar(2) as hakkocycle,  -- 英数字
        rtrim(zaikoitteisu,' 　')::varchar(7) as zaikoitteisu,  -- 英数字
        rtrim(nonukyokbn,' 　')::varchar(1) as nonukyokbn,  -- 英数字
        rtrim(nbscd,' 　')::varchar(2) as nbscd,  -- 英数字
        rtrim(ukeirecd,' 　')::varchar(2) as ukeirecd,  -- 英数字
        rtrim(orosibacd,' 　')::varchar(2) as orosibacd,  -- 英数字
        rtrim(hasusyorium,' 　')::varchar(1) as hasusyorium,  -- 英数字
        rtrim(nonyukgcd,' 　')::varchar(5) as nonyukgcd,  -- 英数字
        rtrim(nonyutni,' 　')::varchar(5) as nonyutni,  -- 英数字
        rtrim(kukuritype,' 　')::varchar(1) as kukuritype,  -- 英数字
        rtrim(kukuritni,' 　')::varchar(5) as kukuritni,  -- 英数字
        rtrim(kensakbn,' 　')::varchar(1) as kensakbn,  -- 英数字
        rtrim(srsirskkojocd,' 　')::varchar(1) as srsirskkojocd,  -- 英数字
        rtrim(brsirskkojocd,' 　')::varchar(1) as brsirskkojocd,  -- 英数字
        rtrim(sirsksyukzyocd,' 　')::varchar(3) as sirsksyukzyocd,  -- 英数字
        rtrim(tekiyokaisiymd,' 　')::varchar(8) as tekiyokaisiymd,  -- 英数字
        rtrim(tekiyosyuryoymd,' 　')::varchar(8) as tekiyosyuryoymd,  -- 英数字
        rtrim(mtuserid,' 　')::varchar(16) as mtuserid,  -- 英数字
        try_to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff9') mttime,
        ldts -- B層のLDTS
    from {{ ref('substr_dvsf509a') }}
)
select * from stg_dvsf509a
where ldts = (select max(ldts) from stg_dvsf509a)