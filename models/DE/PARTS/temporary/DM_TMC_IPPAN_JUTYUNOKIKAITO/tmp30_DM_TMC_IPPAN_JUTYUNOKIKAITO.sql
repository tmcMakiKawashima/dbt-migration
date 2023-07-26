with temp20 as (
    select * from {{ ref("tmp20_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}
    ),
    bokanri as (
        select 
            ORDRKEY -- オーダーキー
          , JURRSYMD -- 受注リリース日
          , SIIRECD -- 仕入先CD
          , max(MARTFLG) MARTFLG -- マル超FLG
        from {{ref('stg_dvnp6490')}} -- BO納期管理資料累積ファイル
        where KOKAGKBN = '1' -- 国内海外区分
        group by 
            ORDRKEY -- オーダーキー
          , JURRSYMD -- 受注リリース日
          , SIIRECD -- 仕入先CD
        )
select
     temp20.*
    ,bokanri.MARTFLG -- マル超FLG
    ,bokanri.SIIRECD -- 仕入先CD
from temp20
left outer join bokanri
on temp20.ORDRKEY = bokanri.ORDRKEY -- オーダーキー
and temp20.JUCHUYMD = bokanri.JURRSYMD -- 受注日/受注リリース日