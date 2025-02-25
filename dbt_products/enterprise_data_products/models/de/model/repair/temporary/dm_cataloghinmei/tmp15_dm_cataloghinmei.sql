with
    tmp10_dm_cataloghinmei as (
        select * from {{ ref('tmp10_dm_cataloghinmei') }}
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
    tmp10_dm_cataloghinmei.*,
    stg_hinbankensakutype2.* exclude (ctlgcd, syasyu_cd, jissijikik, jissijikim)
from tmp10_dm_cataloghinmei
inner join stg_hinbankensakutype2
  on tmp10_dm_cataloghinmei.ctlgcd = stg_hinbankensakutype2.ctlgcd
 and tmp10_dm_cataloghinmei.syasyu_cd = stg_hinbankensakutype2.syasyu_cd
 and tmp10_dm_cataloghinmei.jissijikik = stg_hinbankensakutype2.jissijikik
 and tmp10_dm_cataloghinmei.jissijikim = stg_hinbankensakutype2.jissijikim 