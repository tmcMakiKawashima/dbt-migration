with eth as (select *  from {{source('engineering_db_public','raw_ecitekiyo')}}),
tsy as (select *  from {{ref('stg_eci_tousaisyasyu')}})
select
  eth.lecino as seppenno, -- 設変№
  eth.ecikbn as kubun, -- 区分
  eth.syasyu as syasyu, -- 車種コード
  substr(eth.tekiyo,1,4) as kumitate, -- 組立番号
  substr(eth.tekiyo,5,2) as bui, -- 部位
  substr(eth.tekiyo,7,3) as variation, -- バリエーション
  eth.sinhaikbn as sinhaikbn, -- 新廃区分
  'ECI' as ecikbn, -- 設変書区分
  coalesce(tsy.tousai, rpad('', 4)) as tousai, -- 搭載車種
  rpad('', 30) as cond, -- Condition
  rpad('', 40) as meisyo, -- 名称
  current_timestamp() as ldts -- 最終更新日時
from eth
left join tsy
on (
    eth.seppenno = tsy.seppenno
and eth.ecikbn = tsy.ecikbn
and eth.syasyu = tsy.unitcd
and eth.tekiyo = tsy.tekiyo
)