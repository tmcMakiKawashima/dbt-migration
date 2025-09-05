{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
-- 洗い替えであるため、pre_hookで全件削除を行う。

select
    syasyu,                      -- 車種コード
    kata,                        -- 呼称型式
    sochaku,                     -- 装着形態
    kohin,                       -- 品番
    kohinmei,                    -- 品名名称
    oyakt,                       -- 親工程
    oyaktmeijp,                  -- 親工程工程符号名称(和)
    oyaktmeien,                  -- 親工程工程符号名称(英)
    jyunbn,                      -- 順引き区分
    taisho_month,                -- 年月
    daisu,                       -- 台数
    seppensyonin_time,           -- 設変承認日
    tkkara,                      -- 工場適用カラ
    current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from {{ ref('tmp20_dm_kousei_plantjiseki_kata') }}