with
    KL as (select * from {{ ref('stg_tbdaikl') }}),
    ML as (select * from {{ ref('stg_tbdaiml') }})

select
--KL
      KL.KYOUHAN
    , KL.USERCD
    , IFF(ML.ITAKUFLG <> '1', KL.KYOUHAN, ML.ITAKUHAN) KYOUHAN_ML
    , IFF(ML.ITAKUFLG <> '1', KL.USERCD, ML.ITAKUUSR) USERCD_ML
    , KL.KAISYA
    , KL.TCHUMON
    , KL.FRMKB
    , KL.FRMNO
    , KL.HANKATA
    , KL.SENTER
    , KL.TENPO
    , KL.JZNJUSIN
    , KL.TTYOTE
    , KL.ZAIKYOTE
    , KL.TYAKKO
    , KL.ZAIHATYU
    , KL.KINHATYU
    , KL.LDTS -- snapshot作成用
--ML
    , ML.HINBAN
    , ML.HATYUHIN
    , ML.NYUKOHIN
    , ML.HIKYOTEN
    , ML.JUTYUSU
    , ML.HIKIATE1
    , ML.HIKIATE2
    , ML.HIKIATE3
    , ML.HIKIATE4
    , ML.ZENHIKDD
    , ML.ITAKUFLG
    , ML.DENNO1
    , ML.DENNO2
    , ML.DENNO3
    , ML.DENNO4
    , ML.KYOUHAN as check_KYOUHAN -- nullチェック用
from KL
    left outer join ML
        on KL.KYOUHAN = ML.KYOUHAN
        and KL.HASSIN = ML.HASSIN
        and KL.USERCD = ML.USERCD
        and KL.KAISYA = ML.KAISYA
        and KL.TCHUMON = ML.TCHUMON
        and KL.JZNJUSIN = ML.JZNJUSIN
