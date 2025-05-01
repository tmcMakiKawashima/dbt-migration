{{ config(materialized='table') }}

with tmp10_dm_tekiyohani_all as (
  select * from {{ref('tmp10_dm_tekiyohani_all')}}
), ltekiyo as (
  select
    lecino as seppenno, -- 設変№
    ecikbn as kubun, -- 区分
    syasyu as syasyu, -- 車種コード
    substr(tekiyo,1,4) as kumitate, -- 組立番号
    substr(tekiyo,5,2) as bui, -- 部位
    substr(tekiyo,7,4) as variation, -- バリエーション
    sinhaikbn as sinhaikbn, -- 新廃区分
    rpad('', 4) as tousai, -- 搭載車種
    'LECI' as ecikubun, -- 設変書区分
    rpad('', 40) as meisyo, -- 名称
    rpad('', 30) as cond -- Condition
  from {{source('engineering_db_public','raw_lecitekiyo')}}
), mokujihen as (
  select
    seppenno as seppenno, -- 設変№
    ecikbn as kubun, -- 区分
    syasyu as syasyu, -- 車種コード
    tekiyokumitate as kumitate, -- 組立番号
    tekiyobui as bui, -- 部位
    rpad('', 4) as variation, -- バリエーション
    rpad('', 1) as sinhaikbn, -- 新廃区分
    tousai as tousai, -- 搭載車種
    'ECI(Contents)' as ecikubun, -- 設変書区分
    rpad('', 40) as meisyo, -- 名称
    rpad('', 30) as cond -- Condition
  from {{source('engineering_db_public','raw_ecimokujihen')}}
), lhikihen as (
  select
    lecino as seppenno, -- 設変№
    ecikbn as kubun, -- 区分
    syasyu as syasyu, -- 車種コード
    kumitate as kumitate, -- 組立番号
    bui as bui, -- 部位
    rpad('', 4) as variation, -- バリエーション
    rpad('', 1) as sinhaikbn, -- 新廃区分
    rpad('', 4) as tousai, -- 搭載車種
    'LECI(Contents)' as ecikubun, -- 設変書区分
    rpad('', 40) as meisyo, -- 名称
    rpad('', 30) as cond -- Condition
  from {{source('engineering_db_public','raw_lecihikihen')}}
), meihen as (
  select
    seppenno as seppenno, -- 設変№
    ecikbn as kubun, -- 区分
    syasyu as syasyu, -- 車種コード
    substr(tekiyo,1,4) as kumitate, -- 組立番号
    substr(tekiyo,5,2) as bui, -- 部位
    substr(tekiyo,7,4) as variation, -- バリエーション
    rpad('', 1) as sinhaikbn, -- 新廃区分
    rpad('', 4) as tousai, -- 搭載車種
    'ECI(Name)' as ecikubun, -- 設変書区分
    meisyo as meisyo, -- 名称
    rpad('', 30) as cond -- Condition
  from {{ref('stg_eci_meihen')}}
)
select *
from tmp10_dm_tekiyohani_all
union
select *
from ltekiyo
union
select *
from mokujihen
union
select *
from lhikihen
union
select *
from meihen