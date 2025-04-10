{{ 
  config(
    materialized='incremental',
    unique_key = ['kaisyacd'],
    incremental_strategy = 'append',
    pre_hook=[
      "{{ dbt_snow_mask.create_masking_policy('models')}}",
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ]
  )
}}

with stg_kaisya as (
    select
        kaisyacd::varchar(5) as kaisyacd, -- 会社コード
        gijisskf::varchar(1) as gijisskf, -- 疑似組織フラグ
        sykskokf::varchar(1) as sykskokf, -- 出向先考課フラグ＿技能系
        kscdsykdb::varchar(7) as kscdsykdb, -- 会社コード＿出向ＤＢ
        sskksnam1::varchar(80) as sskksnam1, -- 正式会社名称１
        sskksnam2::varchar(100) as sskksnam2, -- 正式会社名称２
        rsk6ksnam::varchar(12) as rsk6ksnam, -- 会社６文字略称
        rsk3ksnam::varchar(6) as rsk3ksnam, -- 会社３文字略称
        domovscd::varchar(1) as domovscd, -- 国内海外区分コード
        bucd::varchar(2) as bucd, -- 部コード
        sykjirhff::varchar(1) as sykjirhff, -- 出向辞令配布フラグ
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by kaisyacd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20075') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20075')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kaisya where aggkey = 1
