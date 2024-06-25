{{
  config(
    materialized = 'incremental',
    unique_key = ['tsinseiymd', 'shataino'],
    incremental_strategy = 'merge'
  )
}}

with stg_mashotoroku as (
  select
    tsinseiymd::varchar(8) as tsinseiymd, -- 登録申請年月日
    trim(shataino, ' ')::varchar(32) as shataino, -- 車両識別番号
    gyomucd::varchar(2) as gyomucd, -- 業務種別コード
    jikenshameicd::varchar(3) as jikenshameicd, -- 自検協車名コード
    syaryojhkbn::varchar(1) as syaryojhkbn, -- 車両情報提供区分
    ldts, -- b層のldts
    rank() over (partition by tsinseiymd, shataino order by ldts desc) aggkey
  from {{ ref('substr_ktrla01ezz0ko87001') }}

  {% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_mashotoroku where aggkey = 1