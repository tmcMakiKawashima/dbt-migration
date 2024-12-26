with
    tmp02 as (
        select * from {{ ref('tmp_kousei02_blktenkai') }}
    ),
   -- hinban as (
       -- select
           -- hinban, -- 品番
           -- hinmei -- 品名
       -- from {{ ref('stg_hinban') }} -- 品番
       -- where substr(hinban, 8, 1) != '-'
   -- ),
    blkmei as (
        select
            syasyu, -- 車種ユニットコード
            blkcode, -- BLKコード
            blkmei -- BLKコード名称
        from {{ ref('stg_blkmei') }} -- BLKコード名称
        where substr(blkcode, 8, 1) = '-'
    ),
    mokujihonshijun as (
        select
            syasyu_cd, -- 車種コード
            seppenno, -- 設変No.
            torokujun -- 登録／生認順
        from {{ ref('stg_mokujihonshijun') }} -- 目次本紙設変登録順管理
    )
select
    tmp02.*,
   -- hinban.hinmei,
    '' as hinmei, --仮で設定
    blkmei.blkmei,
    mokujihonshijun.seppenno as seppennok,
    mokujihonshijun.seppenno as seppennom
from tmp02
-- left outer join hinban 
--  on tmp02.kohin = hinban.hinban
left outer join blkmei 
  on tmp02.syasyu = blkmei.syasyu
  and tmp02.kohin = blkmei.blkcode
left outer join mokujihonshijun
  on tmp02.jigyoutai = ''
  and tmp02.syasyu = mokujihonshijun.syasyu_cd
  and tmp02.torokujunk = mokujihonshijun.torokujun
left outer join mokujihonshijun
  on tmp02.jigyoutai = ''
  and tmp02.syasyu = mokujihonshijun.syasyu_cd
  and tmp02.torokujunm = mokujihonshijun.torokujun