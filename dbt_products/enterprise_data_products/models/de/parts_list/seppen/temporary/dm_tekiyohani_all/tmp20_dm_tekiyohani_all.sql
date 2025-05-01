{{ config(materialized='table') }}

with tmp10_dm_tekiyohani_all as (
  select * from {{ref('tmp10_dm_tekiyohani_all')}}
), ltekiyo as (
  select
    lecino::varchar(10) as seppenno, -- 設変№
    ecikbn::varchar(3) as kubun, -- 区分
    syasyu::varchar(4) as syasyu, -- 車種コード
    substr(tekiyo,1,4)::varchar(4) as kumitate, -- 組立番号
    substr(tekiyo,5,2)::varchar(2) as bui, -- 部位
    substr(tekiyo,7,4)::varchar(4) as variation, -- バリエーション
    sinhaikbn::varchar(1) as sinhaikbn, -- 新廃区分
    rpad('', 4)::varchar(4) as tousai, -- 搭載車種
    'LECI'::varchar(15) as ecikubun, -- 設変書区分
    rpad('', 40)::varchar(40) as meisyo, -- 名称
    rpad('', 30)::varchar(30) as cond -- Condition
  from {{source('engineering_db_public','raw_lecitekiyo')}}
), mokujihen as (
  select
    seppenno::varchar(10) as seppenno, -- 設変№
    ecikbn::varchar(3) as kubun, -- 区分
    syasyu::varchar(4) as syasyu, -- 車種コード
    tekiyokumitate::varchar(4) as kumitate, -- 組立番号
    tekiyobui::varchar(2) as bui, -- 部位
    rpad('', 4)::varchar(4) as variation, -- バリエーション
    rpad('', 1)::varchar(1) as sinhaikbn, -- 新廃区分
    tousai::varchar(4) as tousai, -- 搭載車種
    'ECI(Contents)'::varchar(15) as ecikubun, -- 設変書区分
    rpad('', 40)::varchar(40) as meisyo, -- 名称
    rpad('', 30)::varchar(30) as cond -- Condition
  from {{source('engineering_db_public','raw_ecimokujihen')}}
), lhikihen as (
  select
    lecino::varchar(10) as seppenno, -- 設変№
    ecikbn::varchar(3) as kubun, -- 区分
    syasyu::varchar(4) as syasyu, -- 車種コード
    kumitate::varchar(4) as kumitate, -- 組立番号
    bui::varchar(2) as bui, -- 部位
    rpad('', 4)::varchar(4) as variation, -- バリエーション
    rpad('', 1)::varchar(1) as sinhaikbn, -- 新廃区分
    rpad('', 4)::varchar(4) as tousai, -- 搭載車種
    'LECI(Contents)'::varchar(15) as ecikubun, -- 設変書区分
    rpad('', 40)::varchar(40) as meisyo, -- 名称
    rpad('', 30)::varchar(30) as cond -- Condition
  from {{source('engineering_db_public','raw_lecihikihen')}}
), meihen as (
  select
    seppenno::varchar(10) as seppenno, -- 設変№
    ecikbn::varchar(3) as kubun, -- 区分
    syasyu::varchar(4) as syasyu, -- 車種コード
    substr(tekiyo,1,4)::varchar(4) as kumitate, -- 組立番号
    substr(tekiyo,5,2)::varchar(2) as bui, -- 部位
    substr(tekiyo,7,4)::varchar(4) as variation, -- バリエーション
    rpad('', 1)::varchar(1) as sinhaikbn, -- 新廃区分
    rpad('', 4)::varchar(4) as tousai, -- 搭載車種
    'ECI(Name)'::varchar(15) as ecikubun, -- 設変書区分
    meisyo::varchar(40) as meisyo, -- 名称
    rpad('', 30)::varchar(30) as cond -- Condition
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