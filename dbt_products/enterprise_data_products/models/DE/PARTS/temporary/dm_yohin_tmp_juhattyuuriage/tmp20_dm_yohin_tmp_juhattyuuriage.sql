{{ config(snowflake_warehouse='DBT_WH') }}

with
    temp10 as (select * from {{ ref('tmp10_dm_yohin_tmp_juhattyuuriage') }}),
    HL as (select * from {{ ref('stg_tbdaihl') }})

select
    temp10.*
  , HL.HATUHINB
  , HL.CHUMON
  , HL.ODERSYU
  , HL.HATTYUHI
from temp10
    left outer join HL
        on temp10.KYOUHAN = HL.KYOUHAN
        and temp10.USERCD = HL.USERCD
        and temp10.KAISYA = HL.KAISYA
        and temp10.TCHUMON = HL.TCHUMON
        and temp10.HINBAN = HL.HINBAN
        and 
            case
                when HL.ODERSYU = '11' then --引当
                    temp10.KINHATYU = HL.HATTYUHI
                when HL.ODERSYU = '12' then --在補
                    temp10.ZAIHATYU = HL.HATTYUHI
            end
