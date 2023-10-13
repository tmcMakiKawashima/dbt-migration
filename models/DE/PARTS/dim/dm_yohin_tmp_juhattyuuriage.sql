with
    temp as (select * from {{ ref('tmp60_dm_yohin_tmp_juhattyuuriage') }})

select
      temp.KYOUHAN
    , temp.HANBAITEN
    , temp.USERCD
    , temp.KJUSRNM
    , temp.KAISYA
    , temp.MAKERCD
    , temp.TCHUMON
    , temp.SENTER
    , temp.TENPO
    , temp.JZNJUSIN
    , temp.TTYOTE
    , temp.ZAIKYOTE
    , temp.TYAKKO
    , temp.HINBAN
    , temp.PNAME
    , temp.HIKYOTEN
    , temp.JUTYUSU
    , temp.ZENHIKDD
    , temp.HATUHINB
    , temp.CHUMON
    , temp.ODERSYU
    , temp.HATTYUHI
    , temp.FRMKB
    , temp.FRMNO
    , temp.HANKATA
    , temp.SYUKKOSU
    , temp.SYUKKOYMD 
    , temp.TKSKBN
    , temp.SISHACD
    , temp.SMKMEIJPJH
    , temp.SMKMEIJPJS
    , temp.LDTS -- snapshot作成用
from temp
order by KYOUHAN, USERCD, KAISYA, TCHUMON, HINBAN, JZNJUSIN, CHUMON, ODERSYU, HATTYUHI