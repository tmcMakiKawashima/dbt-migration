with
    stg_bunkaizukensaku as (
        select
            ctlgcd, -- カタログコード
            figno, -- FIGNO
            bnkren4, -- 分解図連番(4桁)
            hansno, -- 版下NO
            jissijikik, -- 実施時期カラ
            jissijikim, -- 実施時期マデ
            epckataptno, -- EPC型式パターンNO
            ilstcmtno, -- イラストコメントNO
            katahgnjiki, -- 型式表現(時期付き)
            ilstqty -- イラスト枚数
        from {{ ref('stg_bunkaizukensaku') }} -- 分解図検索
    ),
    stg_figmeisyo as (
        select
            langkbn, -- 言語区分
            figno, -- FIGNO
            figmei -- FIG名称
        from {{ ref('stg_figmeisyo') }} -- FIG名称
    )
select
    stg_bunkaizukensaku.*,
    stg_figmeisyo.* exclude (figno)
from stg_bunkaizukensaku
inner join stg_figmeisyo
  on stg_bunkaizukensaku.figno = stg_figmeisyo.figno