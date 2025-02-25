with
    tmp15_dm_cataloghinmei as (
        select * from {{ ref('tmp15_dm_cataloghinmei') }}
    ),
    stg_hinbankensakutype1 as (
        select
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
            hosemhin, -- ホース元品番
            katanomlt -- 型式NO(複数)
        from {{ ref('stg_hinbankensakutype1') }} -- 品番検索Type1
    )
select
    tmp15_dm_cataloghinmei.*,
    stg_hinbankensakutype1.katanomlt
from tmp15_dm_cataloghinmei
inner join stg_hinbankensakutype1
  on tmp15_dm_cataloghinmei.ctlgcd = stg_hinbankensakutype1.ctlgcd
 and tmp15_dm_cataloghinmei.hinmeicd = stg_hinbankensakutype1.hinmeicd
 and tmp15_dm_cataloghinmei.syasyu_cd = stg_hinbankensakutype1.syasyu_cd
 and tmp15_dm_cataloghinmei.hinban = stg_hinbankensakutype1.hinban
 and tmp15_dm_cataloghinmei.kosu = stg_hinbankensakutype1.kosu
 and tmp15_dm_cataloghinmei.jissijikik = stg_hinbankensakutype1.jissijikik
 and tmp15_dm_cataloghinmei.jissijikim = stg_hinbankensakutype1.jissijikim
 and tmp15_dm_cataloghinmei.siyoptno = stg_hinbankensakutype1.siyoptno
 and tmp15_dm_cataloghinmei.epckataptno = stg_hinbankensakutype1.epckataptno
 and tmp15_dm_cataloghinmei.kiricdk = stg_hinbankensakutype1.kiricdk
 and tmp15_dm_cataloghinmei.kiricdm = stg_hinbankensakutype1.kiricdm
 and tmp15_dm_cataloghinmei.trmcdmlt = stg_hinbankensakutype1.trmcdmlt
 and tmp15_dm_cataloghinmei.clrcdmlt = stg_hinbankensakutype1.clrcdmlt
 and tmp15_dm_cataloghinmei.tkstkbn = stg_hinbankensakutype1.tkstkbn
 and tmp15_dm_cataloghinmei.hktkgaikbn = stg_hinbankensakutype1.hktkgaikbn
 and tmp15_dm_cataloghinmei.hosemhin = stg_hinbankensakutype1.hosemhin