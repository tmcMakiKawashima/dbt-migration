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
            katatokukg7 -- 型式特徴記号7
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
    )
select
    stg_syaryokatashikijoho.*,
    stg_syamei.* exclude (ctlgcd)
from stg_syaryokatashikijoho
inner join stg_syamei
  on stg_syaryokatashikijoho.ctlgcd = stg_syamei.ctlgcd