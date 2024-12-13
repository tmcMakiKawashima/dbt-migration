with
    framekatashiki as (
        select
            frmnokata, -- フレームNO型式
            frmno, -- フレームNO
            mdlyearkbn, -- モデルイヤー区分
            vin, -- VIN(17桁)
            nen, -- 年
            tuki, -- 月
            eng_type, -- エンジン型式
            transkata, -- トランスミッション型式
            rdf_type, -- リヤデフ型式
            clrcd, -- カラーコード
            trmcd, -- トリムコード
            syasyu_cd, -- 車種コード
            siyoptno, -- 仕様パターンNO
            tkstkbn, -- 特設区分
            syakata, -- 車両型式
            hanbai_kt, -- 販売型式
            row_number() over (partition by frmnokata, frmno order by ldts desc) aggkey
        from {{ ref('stg_framekatashiki') }} -- フレーム型式
    ),
    syaryokatashikijoho as (
        select
            syakata, -- 車両型式
            syasyu_cd, -- 車種コード
            ctlgcd, -- カタログコード
            jissijikik, -- 実施時期カラ
            jissijikim, -- 実施時期マデ
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
            katatokukg23, -- 型式特徴記号23
            row_number() over (partition by syakata, syasyu_cd order by ldts desc) aggkey
        from {{ ref('stg_syaryokatashikijoho') }} -- 車両型式情報
    )
select
    framekatashiki.* exclude (aggkey),
    syaryokatashikijoho.* exclude (syakata, syasyu_cd, aggkey)
from framekatashiki
inner join syaryokatashikijoho
  on framekatashiki.syakata = syaryokatashikijoho.syakata
 and framekatashiki.syasyu_cd = syaryokatashikijoho.syasyu_cd
where framekatashiki.aggkey = '1'
  and syaryokatashikijoho.aggkey = '1'