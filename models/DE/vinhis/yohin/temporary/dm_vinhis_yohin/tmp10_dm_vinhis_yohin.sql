with
    stg_shinsyameisai as ( 
        select
            dlrcd, -- 販売店コード
            cuno, -- 注文NO.
            edano, -- 枝番
            ym, -- 年月
            syadai_kt, -- 車台型式
            frmno as frm_no -- フレームNO
        from {{ ref('stg_shinsyameisai') }} -- 新車明細
    ),
    stg_yohinmeisai as ( 
        select
            dlrcd, -- 販売店コード
            cuno, -- 注文NO.
            edano, -- 枝番
            ym, -- 年月
            tkcd as tk_cd -- 追工コード
        from {{ ref('stg_yohinmeisai') }} -- 用品明細
    ) 
select
  stg_shinsyameisai.* exclude(dlrcd, cuno, edano, ym),
  stg_yohinmeisai.* exclude(dlrcd, cuno, edano, ym)
from stg_shinsyameisai
left outer join stg_yohinmeisai 
  on stg_shinsyameisai.dlrcd = stg_yohinmeisai.dlrcd
 and rtrim(stg_shinsyameisai.cuno) = stg_yohinmeisai.cuno
 and stg_shinsyameisai.edano = stg_yohinmeisai.edano
 and stg_shinsyameisai.ym = stg_yohinmeisai.ym