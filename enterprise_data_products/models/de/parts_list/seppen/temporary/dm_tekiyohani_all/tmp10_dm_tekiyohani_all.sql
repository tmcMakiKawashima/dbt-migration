with eth as (
  select 
    seppenno, -- 設変№
    ecikbn, -- 区分
    syasyu, -- 車種コード
    tekiyo, -- 適用範囲
    substr(tekiyo,1,4)::varchar(4) as kumitate, -- 組立番号
    substr(tekiyo,5,2)::varchar(2) as bui, -- 部位
    substr(tekiyo,7,4)::varchar(4) as variation, -- バリエーション
    sinhaikbn -- 新廃区分
  from {{source('engineering_db_public','raw_ecitekiyo')}}
),tsy as (
  select * from {{ref('stg_eci_tousaisyasyu')}}
)
select
  eth.* exclude(tekiyo),
  coalesce(tsy.tousai, rpad('', 4))::varchar(4) as tousai, -- 搭載車種
  'ECI'::varchar(15) as ecikubun, -- 設変書区分
  rpad('', 40)::varchar(40) as meisyo, -- 名称
  rpad('', 30)::varchar(30) as cond -- Condition
from eth
left join tsy
on (
    eth.seppenno = tsy.seppenno
and eth.ecikbn = tsy.ecikbn
and eth.syasyu = tsy.unitcd
and eth.tekiyo = tsy.tekiyo
)