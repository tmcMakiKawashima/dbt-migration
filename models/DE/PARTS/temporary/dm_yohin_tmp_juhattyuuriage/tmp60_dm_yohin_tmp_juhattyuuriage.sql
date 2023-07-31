with
    temp50 as (
        select
            KYOUHAN
            , HANBAITEN
            , USERCD
            , KAISYA
            , MAKERCD
            , TCHUMON
            , SENTER
            , TENPO
            , JZNJUSIN
            , TTYOTE
            , ZAIKYOTE
            , TYAKKO
            , HINBAN
            , FRMKB
            , FRMNO
            , HANKATA
            , KINHATYU
            , ZAIHATYU
            , HATYUHIN
            , NYUKOHIN
            , HIKYOTEN
            , JUTYUSU
            , HIKIATE1
            , HIKIATE2
            , HIKIATE3
            , HIKIATE4
            , ZENHIKDD
            , ITAKUFLG
            , DENNO1
            , DENNO2
            , DENNO3
            , DENNO4
            , HATUHINB
            , CHUMON
            , ODERSYU
            , HATTYUHI
            , KJUSRNM
            , SYUKKOSU
            , MAX(SYUKKOYMD) SYUKKOYMD
        from {{ ref('tmp50_dm_yohin_tmp_juhattyuuriage') }}
        group by all
    ),
    atopshimuke as (select * from {{ ref('stg_dvnp054a') }}),
    atopjuchu as (select * from {{ ref('stg_o_cvs11jyuchuu') }}),
    hinban as (select * from {{ ref('stg_dm_pno') }}),
    tasshimuke as (select * from {{ ref('stg_tbsmksk') }})

select
      temp50.*
    , atopjuchu.TKSKBN
    , atopshimuke.SMKMEIJPJH
    , atopshimuke.SMKMEIJPJS
    , hinban.PNAME
    , IFF(tasshimuke.SISHACD is null, '', tasshimuke.SISHACD) as SISHACD
from temp50
    left outer join atopjuchu
        on temp50.HATYUHIN = atopjuchu.JHINBAN
    left outer join hinban
        on temp50.HINBAN = hinban.PNO
    left outer join tasshimuke
        on temp50.KYOUHAN = tasshimuke.KYOUHAN
        and temp50.HIKYOTEN = tasshimuke.KYOTEN
    left outer join atopshimuke
        on TRIM(CONCAT(tasshimuke.KYOUHAN, IFF(tasshimuke.SISHACD is null, '', tasshimuke.SISHACD))) = atopshimuke.DLRCD
