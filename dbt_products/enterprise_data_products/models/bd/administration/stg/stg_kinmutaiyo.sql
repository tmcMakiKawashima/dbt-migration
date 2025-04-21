{{ 
  config(
    materialized='incremental',
    unique_key = ['knmtyostaym','knmtyocd'],
    incremental_strategy = 'append',
    pre_hook=[
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ]
  )
}}
-- 洗い替え処理で常に最新断面のみとするためpre_hookで全件削除する処理を記載
with stg_kinmutaiyo as (
    select
        knmtyostaym::varchar(6) as knmtyostaym, -- 勤務態様有効開始年月
        knmtyocd::varchar(4) as knmtyocd, -- 勤務態様コード
        knmtyobnrcd::varchar(1) as knmtyobnrcd, -- 勤務態様分類コード
        knmtyonam::varchar(40) as knmtyonam, -- 勤務態様名称
        shtsgytim::varchar(4) as shtsgytim, -- 所定始業時刻
        shtsygtim::varchar(4) as shtsygtim, -- 所定終業時刻
        htrsytrodtim::varchar(2) as htrsytrodtim, -- 日当り所定労働時間＿時間
        htrsytrodfun::varchar(2) as htrsytrodfun, -- 日当り所定労働時間＿分
        amnkystkkgrtim::varchar(4) as amnkystkkgrtim, -- 午前年休取得区切時刻
        pmnkystkkgrtim::varchar(4) as pmnkystkkgrtim, -- 午後年休取得区切時刻
        ctmstatim::varchar(4) as ctmstatim, -- コアタイム開始時刻
        ctmendtim::varchar(4) as ctmendtim, -- コアタイム終了時刻
        knmtimcd::varchar(1) as knmtimcd, -- 勤務時間コード
        calkbncd::varchar(2) as calkbncd, -- カレンダー区分コード
        knmtimkbncd::varchar(2) as knmtimkbncd, -- 勤務時刻区分コード
        kyktimtaicnt::varchar(2) as kyktimtaicnt, -- 休憩時間帯数
        x10kykstatim::varchar(40) as x10kykstatim, -- 休憩時間開始時刻Ｘ１０
        x10kykendtim::varchar(40) as x10kykendtim, -- 休憩時間終了時刻Ｘ１０
        x10kyktim::varchar(20) as x10kyktim, -- 休憩時間＿時間Ｘ１０
        x10kykfun::varchar(20) as x10kykfun, -- 休憩時間＿分Ｘ１０
        jisknmtetf::varchar(1) as jisknmtetf, -- 時差勤務手当フラグ
        ktiknmtetf::varchar(1) as ktiknmtetf, -- 交替勤務手当フラグ
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by knmtyostaym, knmtyocd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20074') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20074')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kinmutaiyo where aggkey = 1
