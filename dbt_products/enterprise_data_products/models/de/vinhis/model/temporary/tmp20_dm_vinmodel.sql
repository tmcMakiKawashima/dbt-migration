with
    tmp10 as (
        select * from {{ ref('tmp10_dm_vinmodel') }}
    ),
    syamei as (
        select
            ctlgcd, --カタログコード
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
    tmp10.*,
    syamei.* exclude(ctlgcd)
from tmp10
inner join syamei
  on tmp10.ctlgcd = syamei.ctlgcd