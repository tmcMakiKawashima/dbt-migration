with
    stg_syaryokatashikijoho as (
        select
            ctlgcd, -- カタログコード
            syakata, -- 車両型式
            syasyu_cd, -- 車種コード
            jissijikik, -- 実施時期カラ
            jissijikim, -- 実施時期マデ
            frmnokata, -- フレームNO型式
            katano, -- 型式NO
            katatokukg1, -- 型式特徴記号1
            katatokukg2, -- 型式特徴記号2
            katatokukg3, -- 型式特徴記号3
            katatokukg4, -- 型式特徴記号4
            katatokukg5, -- 型式特徴記号5
            katatokukg6, -- 型式特徴記号6
            katatokukg7, -- 型式特徴記号7
            katatokukg8, -- 型式特徴記号8
            katatokukg9, -- 型式特徴記号9
            katatokukg10, -- 型式特徴記号10
            katatokukg11, -- 型式特徴記号11
            katatokukg12, -- 型式特徴記号12
            katatokukg13, -- 型式特徴記号13
            katatokukg14, -- 型式特徴記号14
            katatokukg15, -- 型式特徴記号15
            katatokukg16, -- 型式特徴記号16
            katatokukg17, -- 型式特徴記号17
            katatokukg18, -- 型式特徴記号18
            katatokukg19, -- 型式特徴記号19
            katatokukg20, -- 型式特徴記号20
            katatokukg21, -- 型式特徴記号21
            katatokukg22, -- 型式特徴記号22
            katatokukg23 -- 型式特徴記号23
        from {{ ref('stg_syaryokatashikijoho') }} -- 車両型式情報
        group by all
    ),
    stg_syamei as (
        select
            ctlgcd, -- カタログコード
            syamei, -- 車名
            syameizen, -- 車名(全角)
            syameizenkana, -- 車名(全角)カナ
            daikata, -- 代表型式
            seisank, -- 生産年月カラ
            seisanm, -- 生産年月マデ
            lexusflg, -- レクサス車フラグ
            prts1kbn, -- 1品番絞り込み区分
            tksyuflg -- 特殊車フラグ
        from {{ ref('stg_syamei') }} -- 車名
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
            srcflg, -- 検索対象フラグ
            tkkatahgn -- 適用型式表現
        from {{ ref('stg_hinbankensakutype2')}} -- 品番検索Type2
    )
select
    stg_syaryokatashikijoho.*,
    stg_syamei.* exclude (ctlgcd),
    stg_hinbankensakutype2.* exclude (ctlgcd)
from stg_syaryokatashikijoho
inner join stg_syamei
  on stg_syaryokatashikijoho.ctlgcd = stg_syamei.ctlgcd
inner join stg_hinbankensakutype2
  on stg_syaryokatashikijoho.ctlgcd = stg_hinbankensakutype2.ctlgcd