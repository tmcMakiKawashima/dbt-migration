with
    dm_latest_sekkei_syasyu as (
        select 
            syasyu,    -- 車種コード
            kata,      -- 呼称型式
            kumitate,  -- 組立番号
            bui,       -- 部位
            variation, -- バリエーション
            sochaku    -- 装着形態
         from {{ source('parts_list_db_public','raw_dm_latest_sekkei') }}
         where syasyu regexp '^[0-9]{1,3}[WJ]$'
    )
select 
    pl.syasyu,                                                   -- 車種コード
    se.kata,                                                     -- 呼称型式
    case when max(se.sochaku) = 'P' and min(se.sochaku) = 'P' then 'P'
         when max(se.sochaku) = 'S' and min(se.sochaku) = 'S' then 'S'
         else 'SP' end as sochaku,                               -- 装着形態
    pl.kohin,                                                    -- 品番
    max(coalesce(pl.kohinmei,'')) as kohinmei,                   -- 品名名称
    pl.oyakt,                                                    -- 親工程
    max(coalesce(pl.oyaktmeijp,'')) as oyaktmeijp,               -- 親工程工程符号名称(和)
    max(coalesce(pl.oyaktmeien,'')) as oyaktmeien,               -- 親工程工程符号名称(英)
    max(coalesce(pl.jyunbn,'')) as jyunbn,                       -- 順引き区分
    substring(
        to_varchar(
            dateadd(month,sabun,to_date(to_varchar(std_month || '01'),'YYYYMMDD'))
                  ,'YYYYMMDD')
            ,1,6)::varchar(6) as taisho_month,                   -- 年月
    max(pl.daisu) as daisu,                                      -- 台数
    max(pl.seppensyonin_time) as seppensyonin_time,              -- 設変承認日
    max(coalesce(pl.tkkara,'')) as tkkara,                       -- 工場適用カラ
    current_timestamp()::timestamp_ntz(9) as ldts                -- 最終更新日時
  from {{ ref('tmp10_dm_kousei_plantjiseki_kata') }} as pl
  left outer join dm_latest_sekkei_syasyu as se
    on se.syasyu = pl.syasyu
   and se.kumitate = pl.kumitate
   and se.bui = pl.bui
   and se.variation = pl.vari
  where se.kata is not null
  group by pl.kohin, pl.syasyu, pl.oyakt, se.kata,
           substring(
                to_varchar(
                    dateadd(month,sabun,to_date(to_varchar(std_month || '01'),'YYYYMMDD'))
                            ,'YYYYMMDD')
                    ,1,6)