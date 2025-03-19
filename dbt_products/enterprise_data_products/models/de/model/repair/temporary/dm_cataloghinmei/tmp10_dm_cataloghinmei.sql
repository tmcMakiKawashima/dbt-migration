with
    stg_hinbankensakutype1 as (
        select
            siyocdmlt, --仕様コード(複数)
            katanomlt, -- 型式NO(複数)
            ctlgcd, -- カタログコード
            hinmeicd, -- 品名コード
            syasyu_cd, -- 車種コード
            hinban, -- 品番
            kosu, -- 個数(検索)
            jissijikik, -- 実施時期カラ
            jissijikim, -- 実施時期マデ
            siyoptno, -- 仕様パターンNO
            epckataptno, -- EPC型式パターンNO
            kiricdk, -- 切替コードカラ
            kiricdm, -- 切替コードマデ
            trmcdmlt, -- トリムコード(複数)
            clrcdmlt, -- カラーコード(複数)
            tkstkbn, -- 特設区分
            hktkgaikbn, -- 引当適用外区分
            hosemhin -- ホース元品番
        from {{ ref('stg_hinbankensakutype1') }} -- 品番検索Type1
    ),
    stg_hinbankensakutype2 as (
        select
            langkbn, -- 言語区分
            ctlgcd, -- カタログコード
            hinmeicd, -- 品名コード
            hinban, -- 品番
            kosu, -- 個数(検索)
            siyoptno, -- 仕様パターンNO
            epckataptno, -- EPC型式パターンNO
            kiricdk, -- 切替コードカラ
            kiricdm, -- 切替コードマデ
            trmcdmlt, -- トリムコード(複数)
            clrcdmlt, -- カラーコード(複数)
            tkstkbn, -- 特設区分
            hktkgaikbn, -- 引当適用外区分
            hosemhin, -- ホース元品番
            syasyu_cd, -- 車種コード
            jissijikik, -- 実施時期カラ
            jissijikim -- 実施時期マデ
        from {{ ref('stg_hinbankensakutype2')}} -- 品番検索Type2
    )
select
    stg_hinbankensakutype1.siyocdmlt, stg_hinbankensakutype1.katanomlt, stg_hinbankensakutype1.ctlgcd,
    stg_hinbankensakutype2.* exclude (ctlgcd)
from stg_hinbankensakutype1
inner join stg_hinbankensakutype2
  on stg_hinbankensakutype1.ctlgcd = stg_hinbankensakutype2.ctlgcd
 and stg_hinbankensakutype1.hinmeicd = stg_hinbankensakutype2.hinmeicd
 and stg_hinbankensakutype1.syasyu_cd = stg_hinbankensakutype2.syasyu_cd
 and stg_hinbankensakutype1.hinban = stg_hinbankensakutype2.hinban
 and stg_hinbankensakutype1.kosu = stg_hinbankensakutype2.kosu
 and stg_hinbankensakutype1.jissijikik = stg_hinbankensakutype2.jissijikik
 and stg_hinbankensakutype1.jissijikim = stg_hinbankensakutype2.jissijikim
 and stg_hinbankensakutype1.siyoptno = stg_hinbankensakutype2.siyoptno
 and stg_hinbankensakutype1.epckataptno = stg_hinbankensakutype2.epckataptno
 and stg_hinbankensakutype1.kiricdk = stg_hinbankensakutype2.kiricdk
 and stg_hinbankensakutype1.kiricdm = stg_hinbankensakutype2.kiricdm
 and stg_hinbankensakutype1.trmcdmlt = stg_hinbankensakutype2.trmcdmlt
 and stg_hinbankensakutype1.clrcdmlt = stg_hinbankensakutype2.clrcdmlt
 and stg_hinbankensakutype1.tkstkbn = stg_hinbankensakutype2.tkstkbn
 and stg_hinbankensakutype1.hktkgaikbn = stg_hinbankensakutype2.hktkgaikbn
 and stg_hinbankensakutype1.hosemhin = stg_hinbankensakutype2.hosemhin
 